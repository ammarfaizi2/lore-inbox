Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262442AbVAZXNj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262442AbVAZXNj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 18:13:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262441AbVAZXMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 18:12:53 -0500
Received: from holomorphy.com ([66.93.40.71]:58794 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262442AbVAZRZn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 12:25:43 -0500
Date: Wed, 26 Jan 2005 09:25:38 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Rik van Riel <riel@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       James Antill <james.antill@redhat.com>,
       Bryn Reeves <breeves@redhat.com>
Subject: Re: don't let mmap allocate down to zero
Message-ID: <20050126172538.GN10843@holomorphy.com>
References: <Pine.LNX.4.61.0501261116140.5677@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0501261116140.5677@chimarrao.boston.redhat.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2005 at 11:18:08AM -0500, Rik van Riel wrote:
> With some programs the 2.6 kernel can end up allocating memory
> at address zero, for a non-MAP_FIXED mmap call!  This causes
> problems with some programs and is generally rude to do. This
> simple patch fixes the problem in my tests.
> Make sure that we don't allocate memory all the way down to zero,
> so the NULL pointer never gets covered up with anonymous memory
> and we don't end up violating the C standard.
> Signed-off-by: Rik van Riel <riel@redhat.com>

SHLIB_BASE does not appear to be present in 2.6.9; perhaps something
else is going on.

I think we are better off:
	(a) checking for hitting zero explicitly as opposed to
		enforcing a randomly-chosen lower limit for addresses
	(b) enforcing vma allocation above FIRST_USER_PGD_NR*PGDIR_SIZE,
		to which SHLIB_BASE bears no relation.


-- wli
