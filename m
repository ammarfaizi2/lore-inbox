Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030297AbWGMTOd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030297AbWGMTOd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 15:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030298AbWGMTOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 15:14:33 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:21263 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030297AbWGMTOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 15:14:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mslZVSIwMuYce0ssb+p4AIJ0jO5jHm+mdugepV5+Ji3nrtD/QKWHpYOIiIvaGz31yetDVuRQuhL40/nMcEueYsaXC2FONl0aVpQW4Vgx2d2v63DODrvKHDeintcjYDDH25B8Kqv72FYp5CrcHxwS+76uG5UWC4DHmXpFjQ+vwyc=
Message-ID: <6bffcb0e0607131214l68232de8lf8cf03f805822f07@mail.gmail.com>
Date: Thu, 13 Jul 2006 21:14:31 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH 00/10] Kernel memory leak detector 0.8
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <b0943d9e0607130935l2d8b2ff1qf1abec1af876f155@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060710220901.5191.66488.stgit@localhost.localdomain>
	 <b0943d9e0607110844m6278da6crdc03bccce420da1d@mail.gmail.com>
	 <6bffcb0e0607110902u4e24a4f2jc6acf2eb4c3bae93@mail.gmail.com>
	 <b0943d9e0607110931n4ce1c569x83aa134e2889926c@mail.gmail.com>
	 <6bffcb0e0607111000q228673a9kcbc6c91f76331885@mail.gmail.com>
	 <b0943d9e0607111454l1f9919eahbb3b683492a651e@mail.gmail.com>
	 <6bffcb0e0607120435x31eceab7r3fdb055a7bee6da2@mail.gmail.com>
	 <b0943d9e0607120917pa0c191aw5814a19b9e6f31fd@mail.gmail.com>
	 <6bffcb0e0607121555n20a9df53q8589109024629f7a@mail.gmail.com>
	 <b0943d9e0607130935l2d8b2ff1qf1abec1af876f155@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,

On 13/07/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> On 12/07/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> > Please try something like this
> > on tty1
> > isic -s rand -d your ip (http://www.packetfactory.net/Projects/ISIC/)
> > on tty2
> > kml_collector (http://www.stardust.webpages.pl/files/o_bugs/kml/ml/kml_collector.sh)
> >
> > (I have tried to read random files from /sys on vanilla kernel, but I
> > can't reproduce that lockup)
>
> Couldn't get it on my (embedded) platform but I think that's because
> there are only a few reports in the memleak file. You have thousands
> of reports and I think reading the memleak file is causing the soft
> lockup.
>
> Until we identify the leak (or false positive), you can use the
> attached patch to supress the reports for context_struct_to_string.
> Hopefully, this should eliminate the soft lockup as well.

Thanks.

After applying context_struct_to_string-not-leak.patch and reverting
alloc_skb-false-positive.patch I haven't noticed that soft lockup.

Here is something new
orphan pointer 0xf40d61ac (size 1536):
  c017392a: <__kmalloc_track_caller>
  c01631b1: <__kzalloc>
  f98869cd: <skge_ring_alloc>
  f9888a1d: <skge_up>
  c02b17b6: <dev_open>
  c02b2e94: <dev_change_flags>
  c02e6e17: <devinet_ioctl>
  c02e8a02: <inet_ioctl>

http://www.stardust.webpages.pl/files/o_bugs/kml/ml2/
http://www.stardust.webpages.pl/files/o_bugs/kml/ml3/

After alloc_skb-false-positive.patch revert
http://www.stardust.webpages.pl/files/o_bugs/kml/ml4/

>
> --
> Catalin

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
