Return-Path: <linux-kernel-owner+w=401wt.eu-S1161144AbXAEQ2D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161144AbXAEQ2D (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 11:28:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161145AbXAEQ2D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 11:28:03 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:52835 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161144AbXAEQ2A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 11:28:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=dKDAQUPLRWdpP2DmSKUCDVDF7RPTkGVlQPO7APcRm+eZ1haVZ9rKyZkNDQ5Z7mt11jkNEjnJB6Tg3hixKgEUFRev0qA0NCPdZuFrtLSguQZHsphTQh+jLK28ZpbvQ1D9Mf1B5krgs2FURByXGA5VIKelyG5swr2kZbhW8azOJNU=
Message-ID: <3efb10970701050827j6146c2bs1b5de7ecb70863bd@mail.gmail.com>
Date: Fri, 5 Jan 2007 17:27:58 +0100
From: "Remy Bohmer" <l.pinguin@gmail.com>
Reply-To: linux@bohmer.net
To: "Dries Kimpe" <Dries.Kimpe@wis.kuleuven.be>
Subject: Re: [BUG-RT] RTC has been stopped-> long delay during boot, soft reboot->GRUB fails to call getrtsecs()
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
In-Reply-To: <3efb10970701050443t3ca6bdf7t1c18aec2b446db0e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_26117_8955184.1168014478602"
References: <459E2F97.3040201@wis.kuleuven.be>
	 <3efb10970701050443t3ca6bdf7t1c18aec2b446db0e@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_26117_8955184.1168014478602
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello All,

Thanks to the hint of Dries, I discovered that there was a difference
in my kernel configuration and the kernel configuration of Ingo
I streamlined my configuration to that of Ingo, and now the slow boot
issue is completely gone. I do not understand the exact relation, but
it works for me.

Thanks to you all.

FYI: Attached I have put the differences I had to make to make it work.


Kind Regards,

Remy Bohmer


2007/1/5, Remy Bohmer <l.pinguin@gmail.com>:
> Hello Dries,
>
> Thanks for your reply, but as it looks a lot like the same problem, I
> want to mention that we do NOT have a Dell system here. It is a
> Fujitsu Siemens i945 motherboard. I also saw the problem about "long
> delays during boot by hwclock" on an old i845 Kontron Motherboard,
> running the same installation/kernel as I mentioned, which we were
> using for years and never showed this problems until we start using
> this kernel. The RTC clock that was stopped is only seen twice on this
> Fujitsu siemens board, not on any other.
>
> So, as it is not a Dell system ,and we therefor have a different BIOS,
> I doubt it is BIOS related. Further, I discovered that the problem
> also occured in a system that is not tickless. I can therefor exclude
> now that it is NOT related to the CONFIG_NO_HZ option, despite what I
> mentioned in my previous mail.
>
> In my case it also was NO battery problem, but removing the battery
> was the only way to reset the RTC to get it ticking again.
>
> We have enabled HPET in BIOS and kernel.
>
> I have tested the 2.6.20rc3-rt0 kernel of Ingo (as he suggested) by
> booting it a few times, and until now we have not seen this problem,
> but the long term will learn if it is really gone.
>
>
> Kind Regards,
>
> Remy B=F6hmer
>
>
>
> 2007/1/5, Dries Kimpe <Dries.Kimpe@wis.kuleuven.be>:
> > In-Reply-To: <3efb10970701020838n61db5388l94b2f0ed38073edd@mail.gmail.c=
om>
> >
> > I found this mail on the LKML.org list, and didn't want to bother to
> > subscribe to the list, so I post this directly. Sorry ;-)
> >
> > I'm suspecting the problem is not related to the rt-kernel at all.
> >
> > This looks like a well known (but no real solution as far as I know)
> > DELL bios problem.
> >
> > * Somehow, the RTC gets corrupted and stops counting.
> > * On recent dell laptops (D420, a.o.) the BIOS sometimes checks the
> > clock (everytime a thorough BIOS check is done)
> > and just stops with the message "time-of-day clock stopped" (look for
> > this on google); On some systems, one can enter the BIOS setup at this
> > point,
> > causing the bios to reset the clock and solving the problem. On others
> > (like the D420), the only problem is to make the B IOS reinitialize the
> > clock.
> >
> > * Once the clock is corrupted, it never runs again (some say a reboot i=
n
> > XP can solve it);
> >  It is NOT a battery problem. Just disconnecting the battery, causing
> > the BIOS to reinitialize NVRAM solves the problem.
> >
> > I use to have this problem on my D420, and it seemed to go away by:
> > - disabling the RTC interrupt in the kernel
> > - enabling the HPET timer RTC emulation
> >
> > More info:
> > http://www.ubuntuforums.org/showthread.php?t=3D176954
> > http://www.ubuntuforums.org/showthread.php?t=3D149565
> > https://launchpad.net/distros/ubuntu/+source/linux-source-2.6.15/+bug/4=
3745
> >
> > Hope this helps.
> >
> >  Greetings,
> >  Dries
> >
> >
> >
> > Disclaimer: http://www.kuleuven.be/cwis/email_disclaimer.htm
> >
>

------=_Part_26117_8955184.1168014478602
Content-Type: text/plain; name=config.diff; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ewktl39g
Content-Disposition: attachment; filename="config.diff"

LS0tIGNvbmZpZy5vbGQJMjAwNy0wMS0wNSAxNzoyMjo0My4wMDAwMDAwMDAgKzAxMDAKKysrIGNv
bmZpZy5uZXcJMjAwNy0wMS0wNSAxNzoyMDozMS4wMDAwMDAwMDAgKzAxMDAKQEAgLTEsNyArMSw3
IEBACiAjCiAjIEF1dG9tYXRpY2FsbHkgZ2VuZXJhdGVkIG1ha2UgY29uZmlnOiBkb24ndCBlZGl0
CiAjIExpbnV4IGtlcm5lbCB2ZXJzaW9uOiAyLjYuMTkuMS1ydDE1Ci0jIFR1ZSBKYW4gIDIgMTU6
MTA6MTQgMjAwNworIyBGcmkgSmFuICA1IDE0OjQwOjU2IDIwMDcKICMKIENPTkZJR19YODZfMzI9
eQogQ09ORklHX0dFTkVSSUNfVElNRT15CkBAIC0xNTQsNiArMTU0LDcgQEAKIENPTkZJR19YODZf
VVNFX1BQUk9fQ0hFQ0tTVU09eQogQ09ORklHX1g4Nl9UU0M9eQogQ09ORklHX0hQRVRfVElNRVI9
eQorQ09ORklHX0hQRVRfRU1VTEFURV9SVEM9eQogQ09ORklHX05SX0NQVVM9MTAKIENPTkZJR19T
Q0hFRF9TTVQ9eQogQ09ORklHX1NDSEVEX01DPXkKQEAgLTk3NywxMCArOTc4LDEwIEBACiAjIENP
TkZJR19XQVRDSERPRyBpcyBub3Qgc2V0CiAjIENPTkZJR19IV19SQU5ET00gaXMgbm90IHNldAog
IyBDT05GSUdfTlZSQU0gaXMgbm90IHNldAotIyBDT05GSUdfUlRDIGlzIG5vdCBzZXQKK0NPTkZJ
R19SVEM9eQorIyBDT05GSUdfUlRDX0hJU1RPR1JBTSBpcyBub3Qgc2V0CiBDT05GSUdfQkxPQ0tF
Uj15CiAjIENPTkZJR19MUFBURVNUIGlzIG5vdCBzZXQKLSMgQ09ORklHX0dFTl9SVEMgaXMgbm90
IHNldAogIyBDT05GSUdfRFRMSyBpcyBub3Qgc2V0CiAjIENPTkZJR19SMzk2NCBpcyBub3Qgc2V0
CiAjIENPTkZJR19BUFBMSUNPTSBpcyBub3Qgc2V0CkBAIC05OTYsNyArOTk3LDkgQEAKICMgQ09O
RklHX05TQ19HUElPIGlzIG5vdCBzZXQKICMgQ09ORklHX0NTNTUzNV9HUElPIGlzIG5vdCBzZXQK
ICMgQ09ORklHX1JBV19EUklWRVIgaXMgbm90IHNldAotIyBDT05GSUdfSFBFVCBpcyBub3Qgc2V0
CitDT05GSUdfSFBFVD15CisjIENPTkZJR19IUEVUX1JUQ19JUlEgaXMgbm90IHNldAorIyBDT05G
SUdfSFBFVF9NTUFQIGlzIG5vdCBzZXQKICMgQ09ORklHX0hBTkdDSEVDS19USU1FUiBpcyBub3Qg
c2V0CiAKICMKQEAgLTEzMjgsNyArMTMzMSwzNSBAQAogIwogIyBSZWFsIFRpbWUgQ2xvY2sKICMK
LSMgQ09ORklHX1JUQ19DTEFTUyBpcyBub3Qgc2V0CitDT05GSUdfUlRDX0xJQj15CitDT05GSUdf
UlRDX0NMQVNTPXkKK0NPTkZJR19SVENfSENUT1NZUz15CitDT05GSUdfUlRDX0hDVE9TWVNfREVW
SUNFPSJydGMwIgorIyBDT05GSUdfUlRDX0RFQlVHIGlzIG5vdCBzZXQKKworIworIyBSVEMgaW50
ZXJmYWNlcworIworQ09ORklHX1JUQ19JTlRGX1NZU0ZTPXkKK0NPTkZJR19SVENfSU5URl9QUk9D
PXkKK0NPTkZJR19SVENfSU5URl9ERVY9eQorIyBDT05GSUdfUlRDX0lOVEZfREVWX1VJRV9FTVVM
IGlzIG5vdCBzZXQKKworIworIyBSVEMgZHJpdmVycworIworIyBDT05GSUdfUlRDX0RSVl9YMTIw
NSBpcyBub3Qgc2V0CisjIENPTkZJR19SVENfRFJWX0RTMTMwNyBpcyBub3Qgc2V0CisjIENPTkZJ
R19SVENfRFJWX0RTMTU1MyBpcyBub3Qgc2V0CisjIENPTkZJR19SVENfRFJWX0lTTDEyMDggaXMg
bm90IHNldAorIyBDT05GSUdfUlRDX0RSVl9EUzE2NzIgaXMgbm90IHNldAorIyBDT05GSUdfUlRD
X0RSVl9EUzE3NDIgaXMgbm90IHNldAorIyBDT05GSUdfUlRDX0RSVl9QQ0Y4NTYzIGlzIG5vdCBz
ZXQKKyMgQ09ORklHX1JUQ19EUlZfUENGODU4MyBpcyBub3Qgc2V0CisjIENPTkZJR19SVENfRFJW
X1JTNUMzNzIgaXMgbm90IHNldAorIyBDT05GSUdfUlRDX0RSVl9NNDhUODYgaXMgbm90IHNldAor
IyBDT05GSUdfUlRDX0RSVl9URVNUIGlzIG5vdCBzZXQKKyMgQ09ORklHX1JUQ19EUlZfVjMwMjAg
aXMgbm90IHNldAogCiAjCiAjIERNQSBFbmdpbmUgc3VwcG9ydAo=
------=_Part_26117_8955184.1168014478602--
