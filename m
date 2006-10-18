Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422637AbWJRQSa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422637AbWJRQSa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 12:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422638AbWJRQSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 12:18:30 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:9440 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1422637AbWJRQS3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 12:18:29 -0400
Date: Wed, 18 Oct 2006 18:15:27 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linus Torvalds <torvalds@osdl.org>
cc: Al Viro <viro@ftp.linux.org.uk>, Alexey Dobriyan <adobriyan@gmail.com>,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: dealing with excessive includes
In-Reply-To: <Pine.LNX.4.64.0610180759070.3962@g5.osdl.org>
Message-ID: <Pine.LNX.4.61.0610181814100.31301@yvahk01.tjqt.qr>
References: <20061017005025.GF29920@ftp.linux.org.uk>
 <Pine.LNX.4.64.0610161847210.3962@g5.osdl.org> <20061017043726.GG29920@ftp.linux.org.uk>
 <Pine.LNX.4.64.0610170821580.3962@g5.osdl.org> <20061018044054.GH29920@ftp.linux.org.uk>
 <20061018091944.GA5343@martell.zuzino.mipt.ru> <20061018093126.GM29920@ftp.linux.org.uk>
 <Pine.LNX.4.64.0610180759070.3962@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> +#define lock_super(x) do {		\
>> +	struct super_block *sb = x;	\
>> +	get_fs_excl();			\
>> +	mutex_lock(&sb->s_lock);	\
>> +} while(0)
>
>Don't do this. The "x" passed in may be "sb", and then you end up with 
>bogus code.

So how about:

static inline void lock_super(struct super_block *sb)
{
	get_fs_excl();
	mutex_lock(&sb->s_lock);
	return;
}

which avoids any naming issue.


	-`J'
-- 
