Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261197AbVDMSjG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbVDMSjG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 14:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261195AbVDMSjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 14:39:05 -0400
Received: from THUNK.ORG ([69.25.196.29]:19399 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261197AbVDMShx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 14:37:53 -0400
Date: Wed, 13 Apr 2005 14:37:43 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Richard B. Johnson" <linux-os@analogic.com>
Cc: Hacksaw <hacksaw@hacksaw.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Tomko <tomko@haha.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Why system call need to copy the date from the userspace before using it
Message-ID: <20050413183742.GA5252@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	"Richard B. Johnson" <linux-os@analogic.com>,
	Hacksaw <hacksaw@hacksaw.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Tomko <tomko@haha.com>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
References: <200504131159.j3DBxsoa010918@hacksaw.org> <Pine.LNX.4.61.0504130818300.12518@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0504130818300.12518@chaos.analogic.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2005 at 08:40:05AM -0400, Richard B. Johnson wrote:
> The kernel does NOT have to copy data from user-space before
> using it. 

Incorrect.  It must, or the kernel code in question is by definition
buggy.

> In fact, user-mode pointers are valid in kernel-space
> when the kernel is performing a function on behalf of the user-
> mode code. 

On some architectures, this is true.  But not all architectures, and
not in all circumstances.  For example, even on the x86 architecture,
in the 4G/4G mode, a user-mode pointer is *not* valid when kernel code
is running.  You must use copy_to_user()/copy_from_user().  Simply
dereferencing a user-mode pointer is a BUG.  It might work sometimes,
on some architectures, but not everywhere.  Therefore, for correctly
written kernel code, you must not do it.

						- Ted
