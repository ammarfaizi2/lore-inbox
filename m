Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964795AbWDBWJr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964795AbWDBWJr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 18:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965030AbWDBWJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 18:09:47 -0400
Received: from zproxy.gmail.com ([64.233.162.197]:7403 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964795AbWDBWJr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 18:09:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PZHfgKuBYt4tLkGXp5xatxrMcgMFH1/bhHRL9vkGg/O39RJ5E6NBMNLlbxot3PyfEXWd4PbuuW++mfpX2eR0oH3n5t4bYgjHb/qw0Rr8F/q7lzcJPEpUZUCmrxIr9RHtX11P6QBtkoXhq+SqdOmDPRuF86PrPwPwiWP5sq6pBCQ=
Message-ID: <bda6d13a0604021509l4bbc6edar672d99f9b6537347@mail.gmail.com>
Date: Sun, 2 Apr 2006 15:09:46 -0700
From: "Joshua Hudson" <joshudson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: RFC replace some locking of i_sem wiht atomic_t
In-Reply-To: <bda6d13a0604021508g3cc03506yce0170166dc0eda2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <bda6d13a0603311608p5b74df13i259c2b9efa539330@mail.gmail.com>
	 <bda6d13a0604021101h6cd362efn6d832bfb1275080c@mail.gmail.com>
	 <20060402184315.GD27946@ftp.linux.org.uk>
	 <bda6d13a0604021508g3cc03506yce0170166dc0eda2@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/2/06, Al Viro <viro@ftp.linux.org.uk> wrote:
> On Sun, Apr 02, 2006 at 11:01:30AM -0700, Joshua Hudson wrote:
> > Herein lies the problem with the current locking scheme:
> > 1. rename locks target if it exists, but target may be created by
> > link() immediately
> > after the check&lock procedure.
> > 2. The target of link() is completely unprotected.
>
> 3. You have failed to RTFS or RTFM.
>
Ah here we are

directory-locking.txt shows link() does:
lock parent
insure that source is not a directory
lock source

Let me guess, parent means parent of target, not parent of source.
This has been confusing me for months. Thanks for streightning me out.
