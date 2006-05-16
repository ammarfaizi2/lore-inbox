Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751233AbWEPPd3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbWEPPd3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 11:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbWEPPd3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 11:33:29 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:65243 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751233AbWEPPd2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 11:33:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sLlRAsSs4Kb50o11GU+4lrgxkKw879wzKv2ToFVCLwZktBVAr5qByUIyj+d1YgMJTbfmWlDoM/Kzl/zbOJtNbT+sONgDCabHS8Pxrz/NVUpi0PI117aJ8ErU6pYDhLBdYyAcfV25MXaVrXiYRoe/4TIR3icoPtpKhnGkvWSP+Mc=
Message-ID: <3b0ffc1f0605160833k5f6355c5n3f2a9ab1b211a95@mail.gmail.com>
Date: Tue, 16 May 2006 11:33:27 -0400
From: "Kevin Radloff" <radsaq@gmail.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATCH: Fix broken PIO with libata
Cc: linux-kernel@vger.kernel.org, "Tejun Heo" <htejun@gmail.com>,
       jgarzik@pobox.com, torvalds@osdl.org
In-Reply-To: <1147790393.2151.62.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1147790393.2151.62.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/16/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> The revaldiation in 2.6.17-rc has broken support for PIO only devices.
> This is fairly unusual in the SATA world but showed up rather more
> promptly with the added PATA drivers.

Excellent; this seems to have solved my oops on CF card insertion problem. :)

However, I still have a problem with pata_pcmcia (that I actually
experienced also with the ide-cs driver) where sustained reading or
writing to the CF card spikes the CPU with nearly 100% system time.
Here's a few seconds of 'vmstat 5' with a 'cat /dev/sdb > /dev/null'
in the middle of it:

procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  1      0 502608  13304 254740    0    0   164    42 1089   618  7  2 85  5
 1  1      0 495440  20472 254740    0    0  1434     7 1078  1079  1 95  0  4
 1  1      0 487264  28664 254740    0    0  1638     8 1073  1063  1 95  0  4
 1  1      0 479940  35832 254740    0    0  1434    50 1077  1087  1 95  0  4
 1  1      0 472320  43000 254740    0    0  1434    15 1078  1093 10 86  0  4
 1  1      0 465104  50168 254740    0    0  1434    56 1077  1053  6 90  0  4
 1  1      0 456944  58360 254740    0    0  1638     8 1072  1063  1 94  0  5
 1  1      0 449744  65528 254740    0    0  1434     3 1073  1069  1 94  0  5
 1  1      0 441600  73720 254740    0    0  1638     5 1072  1071  1 95  0  4
 1  1      0 434020  80888 254740    0    0  1434     0 1074  1087 11 85  0  4
 0  0      0 428896  86008 254740    0    0  1024     3 1184  1313  4 83 11  3
 0  0      0 428896  86008 254740    0    0     0     5 1105  1057  1  0 98  0


-- 
Kevin 'radsaq' Radloff
radsaq@gmail.com
http://thesaq.com/
