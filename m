Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262473AbVA0DRN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262473AbVA0DRN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 22:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262452AbVA0DQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 22:16:56 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49861 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262473AbVA0DPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 22:15:44 -0500
Date: Thu, 27 Jan 2005 03:15:39 +0000
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: John Richard Moser <nigelenki@comcast.net>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: /proc parent &proc_root == NULL?
Message-ID: <20050127031539.GK8859@parcelfarce.linux.theplanet.co.uk>
References: <41F82218.1080705@comcast.net> <41F84313.4030509@osdl.org> <41F8530C.6010305@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41F8530C.6010305@comcast.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2005 at 09:33:48PM -0500, John Richard Moser wrote:
> create_proc_entry("kmsg", S_IRUSR, &proc_root);
> 
> So this is asking for proc_root to be filled?
> 
> create_proc_entry("kcore", S_IRUSR, NULL);
> 
> And this is just saying to shove it in proc's root?

NULL is equivalent to &proc_root in that context; moreover, it's better
style - drivers really shouldn't be refering to what is procfs-private
object.

> I'm trying to locate a specific proc entry, using this lovely piece of
> code I ripped off:

That's not something allowed outside of procfs code - lifetime rules
alone make that a Very Bad Idea(tm).  If that's just debugging - OK,
but if your code really uses that stuff, I want details on the intended
use.  In that case your design is almost certainly asking for trouble.
