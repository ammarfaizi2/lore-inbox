Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262440AbVA0Bo2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262440AbVA0Bo2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 20:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262473AbVA0Bj6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 20:39:58 -0500
Received: from fire.osdl.org ([65.172.181.4]:54462 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S262459AbVA0Bgz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 20:36:55 -0500
Message-ID: <41F84313.4030509@osdl.org>
Date: Wed, 26 Jan 2005 17:25:39 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Richard Moser <nigelenki@comcast.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: /proc parent &proc_root == NULL?
References: <41F82218.1080705@comcast.net>
In-Reply-To: <41F82218.1080705@comcast.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Richard Moser wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> proc_misc_init() has both these lines in it:
> 
> entry = create_proc_entry("kmsg", S_IRUSR, &proc_root);
> proc_root_kcore = create_proc_entry("kcore", S_IRUSR, NULL);
> 
> Both entries show up in /proc, as /proc/kmsg and /proc/kcore.  So I ask,
> as I can't see after several minutes of examination, what's the
> difference?  Why is NULL used for some and &proc_root used for others?
> 
> I'm looking at 2.6.10

create_proc_entry() passes &parent to proc_create().
See proc_create():
...
This is an error path:
	if (!(*parent) && xlate_proc_name(name, parent, &fn) != 0)
		goto out;
but xlate_proc_name() searches for a /proc/.... and returns the 
all-but-final-part-of-name *parent (hope that makes some sense,
see the comments above the function), so it returns &proc_root.

HTH.  If not, fire back.
-- 
~Randy
