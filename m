Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264136AbTKZKR7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 05:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264141AbTKZKR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 05:17:59 -0500
Received: from holomorphy.com ([199.26.172.102]:12221 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264136AbTKZKR5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 05:17:57 -0500
Date: Wed, 26 Nov 2003 02:17:44 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Amir Hermelin <amir@montilio.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PG_reserved bug
Message-ID: <20031126101744.GJ8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Amir Hermelin <amir@montilio.com>, linux-kernel@vger.kernel.org
References: <001501c3b405$75d49c90$1d01a8c0@CARTMAN>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001501c3b405$75d49c90$1d01a8c0@CARTMAN>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 26, 2003 at 12:09:58PM +0200, Amir Hermelin wrote:
> Hi,
> I've found a bug in the 2.4.20 kernel (might have appeared before), that if
> the PG_reserved flag is set on a page, its reference count will be
> incremented but won't be decremented.  This is due to the wrong order of
> lazy if tests in __free_pages().
> I have two questions:
> 1.  How do I report it?  I found no maintainer for MM in MAINTAINERS
> 2.  I'm writing a module that gets pages (via __get_free_pages) and holds
> them throughout its lifetime.  Where must I check if this page can be taken
> from under me, without using the reserved bit?  In other words, if I want to
> make sure the behavior is the same with or without the reserved bit, what
> must I maintain?

Reserved pages are excepted from normal reference counting rules. The
allocators of reserved pages are expected to clear reference counts
themselves before returning them to the system (if they ever do).


-- wli
