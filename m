Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261306AbVGLMi3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261306AbVGLMi3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 08:38:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261412AbVGLMi2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 08:38:28 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:42459 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261306AbVGLMgi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 08:36:38 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [patch 7/12] s390: fba dasd i/o errors.
Date: Tue, 12 Jul 2005 15:36:19 +0300
User-Agent: KMail/1.5.4
Cc: akpm@osdl.org, Horst Hummel <horst.hummel@de.ibm.com>,
       linux-kernel@vger.kernel.org
References: <OF4C6CD4B3.003279A6-ON4225703C.0039E4A7-4225703C.003A3B95@de.ibm.com>
In-Reply-To: <OF4C6CD4B3.003279A6-ON4225703C.0039E4A7-4225703C.003A3B95@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507121536.19848.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 12 July 2005 13:36, Martin Schwidefsky wrote:
> > > @@ -354,6 +354,8 @@ dasd_fba_build_cp(struct dasd_device * d
> > >          }
> > >          cqr->device = device;
> > >          cqr->expires = 5 * 60 * HZ;         /* 5 minutes */
> > > +        cqr->retries = 32;
> >
> > 2..4 maybe, but 32? This isn't tiny by any account.
> 
> Are you arguing the use of the adjective "tiny" or the technical
> aspects of using 32 as the number of retries for dasd fba?
> In the dasd driver we use a retry count of 255 as "standard", so
> 32 is indeed much smaller than that. If you can call it tiny,
> well who cares??

I meant that 32 retries is too many. Retries tend to multiply.
If OS does N retries per failed attempt and disk drive does M
attempts per attempt, you end up with N*M retries.
Add a few 'retrying' layers, and you have a 'I cannot umount
this fscking scratched CDROM, maybe tomorrow' type disaster.

It's better to err to the smaller number of attempts.
--
vda

