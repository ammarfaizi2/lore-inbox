Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292778AbSBUVmv>; Thu, 21 Feb 2002 16:42:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292759AbSBUVml>; Thu, 21 Feb 2002 16:42:41 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:26642
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S292467AbSBUVmX>; Thu, 21 Feb 2002 16:42:23 -0500
Date: Thu, 21 Feb 2002 13:30:15 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.5 IDE cleanup 11
In-Reply-To: <Pine.LNX.4.10.10202211323170.31576-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.10.10202211329040.31576-200000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="1430322656-1471099195-1014327015=:31576"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1430322656-1471099195-1014327015=:31576
Content-Type: text/plain; charset=us-ascii


Alan,

Sorry I forgot to include the patch.

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development

On Thu, 21 Feb 2002, Andre Hedrick wrote:

> On Thu, 21 Feb 2002, Alan Cox wrote:
> 
> > > This is the next round of IDE driver cleanups.
> > 
> > How about fixing the stuff you've already messed up (like putting the
> > drive present flags and the probe return back) ? The changes you made
> > to the init code also broke the framework so that 2.5 would eventually
> > let you do
> > 
> > 	open("/dev/cdrom")
> > 	read/write
> > 	close("/dev/cdrom")
> > 	open("/dev/sda")		/* Same device */
> > 	burn a cd
> > 
> > without loading/unloading modules
> > 
> > I'm also confused how you plan to fix the hot swap case after your changes
> > because you've not allowed for the fact drives might be hot swapped while
> > you are suspended. The old code was careful to keep the hooks for that
> > ready.
> >
> > Finally you forgot to update the MAINTAINER entry since you've now clearly
> > decided to walk over Andre and become the IDE maintainer
> > 
> > Alan
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 
> Alan,
> 
> Please let me correct this issue as now I am going to start new driver
> since this one is now beyond repair for me.
> 
> Regards,
> 
> Andre Hedrick
> Linux Disk Certification Project                Linux ATA Development
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


--1430322656-1471099195-1014327015=:31576
Content-Type: text/plain; charset=us-ascii; name="ide-2.5.5.patch"
Content-Transfer-Encoding: base64
Content-ID: <Pine.LNX.4.10.10202211330150.31576@master.linux-ide.org>
Content-Description: 
Content-Disposition: attachment; filename="ide-2.5.5.patch"

LS0tIGxpbnV4LTIuNS41LXByaXN0aW5lL01BSU5UQUlORVJTLm9yaWcJVGh1
IEZlYiAyMSAxMzoyNjo0NCAyMDAyDQorKysgbGludXgtMi41LjUtcHJpc3Rp
bmUvTUFJTlRBSU5FUlMJVGh1IEZlYiAyMSAxMzozMDo1NiAyMDAyDQpAQCAt
Njk3LDEzICs2OTcsOSBAQA0KIFM6ICAgICAgU3VwcG9ydGVkIA0KIA0KIElE
RSBEUklWRVIgW0dFTkVSQUxdDQotUDoJQW5kcmUgSGVkcmljaw0KLU06CWFu
ZHJlQGxpbnV4LWlkZS5vcmcNCi1NOglhbmRyZUBsaW51eGRpc2tjZXJ0Lm9y
Zw0KK1A6CU1hcnRpbiBEYWxlY2tpCQ0KK006CU1hcnRpbiBEYWxlY2tpIDxk
YWxlY2tpQGV2aXNpb24tdmVudHVyZXMuY29tPg0KIEw6CWxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmcNCi1XOglodHRwOi8vd3d3Lmtlcm5lbC5vcmcv
cHViL2xpbnV4L2tlcm5lbC9wZW9wbGUvaGVkcmljay8NCi1XOglodHRwOi8v
d3d3LmxpbnV4LWlkZS5vcmcvDQotVzoJaHR0cDovL3d3dy5saW51eGRpc2tj
ZXJ0Lm9yZy8NCiBTOglNYWludGFpbmVkDQogDQogSURFL0FUQVBJIENEUk9N
IERSSVZFUg0KQEAgLTE1MjMsNiArMTUxOSwxNiBAQA0KIEw6CXZ0dW5Ab2Zm
aWNlLnNhdGl4Lm5ldA0KIFc6CWh0dHA6Ly92dHVuLnNvdXJjZWZvcmdlLm5l
dC90dW4NCiBTOglNYWludGFpbmVkDQorDQorU0FUQS9QQVRBL0FDQiBEUklW
RVIgW0FMTF0NCitQOglBbmRyZSBIZWRyaWNrDQorTToJYW5kcmVAbGludXgt
aWRlLm9yZw0KK006CWFuZHJlQGxpbnV4ZGlza2NlcnQub3JnDQorTDoJbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KK1c6CWh0dHA6Ly93d3cua2Vy
bmVsLm9yZy9wdWIvbGludXgva2VybmVsL3Blb3BsZS9oZWRyaWNrLw0KK1c6
CWh0dHA6Ly93d3cubGludXgtaWRlLm9yZy8NCitXOglodHRwOi8vd3d3Lmxp
bnV4ZGlza2NlcnQub3JnLw0KK1M6CUZ1dHVyZSBDcmVhdGlvbg0KIA0KIFUx
NC0zNEYgU0NTSSBEUklWRVINCiBQOglEYXJpbyBCYWxsYWJpbw0K
--1430322656-1471099195-1014327015=:31576--
