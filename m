Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751257AbWJQTuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbWJQTuG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 15:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbWJQTuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 15:50:05 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:11162 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751252AbWJQTuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 15:50:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=qtRsFU5bnzs6hUhWZbwPPMfLQfHy9RoAujkg65kEQ044hPxBhFynFwP9fwLmAq6b/R4ZcBLB7aWB430+IpJhviCENFiuXUMp6p7oJRQ1C3swneHwizarLqOTawjIwCQ8mgadVuzco991evAx1VomP5FooSkz0qZ9SHlZRUBjqlc=
Date: Tue, 17 Oct 2006 21:50:22 +0200
From: Luca Tettamanti <kronos.it@gmail.com>
To: Joerg Schilling <Joerg.Schilling@fokus.fraunhofer.de>
Cc: ismail@pardus.org.tr, linux-kernel@vger.kernel.org
Subject: Re: Linux ISO-9660 Rock Ridge bug needs fix
Message-ID: <20061017195022.GA23792@dreamland.darkstar.lan>
References: <20061017180210.GA20287@dreamland.darkstar.lan> <200610172114.30268.ismail@pardus.org.tr> <45351de7.ky2ldiUVUFoikxQ6%Joerg.Schilling@fokus.fraunhofer.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45351de7.ky2ldiUVUFoikxQ6%Joerg.Schilling@fokus.fraunhofer.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il Tue, Oct 17, 2006 at 08:16:07PM +0200, Joerg Schilling ha scritto: 
> Ismail Donmez <ismail@pardus.org.tr> wrote:
> 
> > I was just trying a fast hack to see it works ;-) but iso files produced by 
> > latest mkisofs works fine even without patching.
> 
> Did you _really_ use the latest mkisofs?

Yes, of course. As I said, the size of PX record is different:

000b820: 0100 5350 0701 beef 0052 5205 0181 5058  ..SP.....RR...PX
000b830: 2c01 6d41 0000 0000 416d 0200 0000 0000  ,.mA....Am......
         ^^ size is 44

but isofs (I'm using 2.6.19-rc2) doesn't care. If I'm reading the code
correctly record size is validated against (dentry size - name len -
records already parsed); it may be possibile to trigger the failure with
a certain combination of records (directory relocation?).
With my patch it should never happens that expected attributes size is
greater than dentry size.
Anyway, if you have a (small) image that triggers the error I can double
check the code.


Luca
-- 
#include <stdio.h> 
int main(void) {printf("\t\t\b\b\b\b\b\b");
printf("\t\t\b\b\b\b\b\b");return 0;}
