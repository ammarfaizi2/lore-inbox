Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261740AbVC3Dg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261740AbVC3Dg2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 22:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261744AbVC3Dg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 22:36:28 -0500
Received: from main.gmane.org ([80.91.229.2]:26258 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261740AbVC3DgT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 22:36:19 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: [PATCH] embarassing typo
Date: Wed, 30 Mar 2005 05:35:54 +0200
Message-ID: <yw1x8y45ztyd.fsf@ford.inprovide.com>
References: <200503292331.46832.vicente.feito@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 76.80-203-227.nextgentel.com
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:d++RnixjambMWQ7xlUy9WmYnxQA=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vicente Feito <vicente.feito@gmail.com> writes:

> On Tuesday 29 March 2005 09:58 pm, you wrote:
>> Måns Rullgård wrote:
>> > "Ronald S. Bultje" <rbultje@ronald.bitfreak.net> writes:
>> >>--- linux-2.6.5/drivers/media/video/zr36050.c.old 16 Sep 2004 22:53:27
>> >> -0000 1.2 +++ linux-2.6.5/drivers/media/video/zr36050.c 29 Mar 2005
>> >> 20:30:23 -0000 @@ -419,7 +419,7 @@
>> >>  dri_data[2] = 0x00;
>> >>  dri_data[3] = 0x04;
>> >>  dri_data[4] = ptr->dri >> 8;
>> >>- dri_data[5] = ptr->dri * 0xff;
>> >>+ dri_data[5] = ptr->dri & 0xff;
>> >
>> > Hey, that's a nice obfuscation of a simple negation.
>>
>> It's not a negation.  This statement always assigns zero to
>> dri_data[5] if dri_data is char[].  Looks like gcc isn't catching
>> this problem.
>>
> As long as the variable doesn't get overflowed you would have a
> negation, you shouldn't do dri_data[5] = ptr->dri * 0xff; if
> ptr->dri it's 255, but if ptr->dri = 1 i.e. (like is set in
> zr36050_setup) then you would be getting the negation, -1. the
> Direct rendering support is a flag afaik, so in this case I believe
> is a worthy C obfuscated negation code :)
> btw, are you sure about this patch?I would contact the maintainer
> first, because and'ing that doesn't make much sense...

It seems pretty obvious to me, that the code is supposed to store the
high byte in dri_data[4], and the low byte in dri_data[5].  Mistyping
& as * doesn't seem too unlikely, either.

-- 
Måns Rullgård
mru@inprovide.com

