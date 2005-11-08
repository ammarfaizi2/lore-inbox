Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964996AbVKHUdj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964996AbVKHUdj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 15:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965005AbVKHUdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 15:33:39 -0500
Received: from vena.lwn.net ([206.168.112.25]:45189 "HELO lwn.net")
	by vger.kernel.org with SMTP id S964996AbVKHUdj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 15:33:39 -0500
Message-ID: <20051108203337.15569.qmail@lwn.net>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/18] allow callers of seq_open do allocation themselves 
From: corbet@lwn.net (Jonathan Corbet)
In-reply-to: Your message of "Tue, 08 Nov 2005 02:01:31 GMT."
             <E1EZInj-0001Eh-9T@ZenIV.linux.org.uk> 
Date: Tue, 08 Nov 2005 13:33:37 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@ftp.linux.org.uk> wrote:

> Allows caller of seq_open() to kmalloc() seq_file + whatever else they want
> and set ->private_data to it.  seq_open() will then abstain from doing
> allocation itself.

It looks like seq_release() frees the structure regardless of where it
came from.  So the seq_file structure must be the first field in
whatever structure contains it, and one has to hope that won't change in
the future.  Is that really the way the interface was meant to work?

jon
