Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964794AbVHYEqr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964794AbVHYEqr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 00:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964795AbVHYEqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 00:46:47 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:19367 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964794AbVHYEqq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 00:46:46 -0400
Date: Wed, 24 Aug 2005 21:46:34 -0700
From: Paul Jackson <pj@sgi.com>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: jesper.juhl@gmail.com, linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [PATCH 3/3] exterminate strtok - usr/gen_init_cpio.c
Message-Id: <20050824214634.6008be53.pj@sgi.com>
In-Reply-To: <200508242106.j7OL61QK010645@laptop11.inf.utfsm.cl>
References: <200508242108.53198.jesper.juhl@gmail.com>
	<200508242106.j7OL61QK010645@laptop11.inf.utfsm.cl>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst wrote:
> > -		if ('\n' == *type) {
> > +		if (!*type || '\n' == *type) {
> 
> Redundant. If *type == '\n', it is certainly != 0.

No - I don't think redundant, at least not this change in isolation.
Perhaps redundant in light of subsequent code lines, as Jesper notes in
his followup.

But it is confusing to read - poor and inconsistent choice of code
phrasing.

If the patch had read as:
    -		if (*type == '\n') {
    +		if (*type == '\n' || *type == '\0') {

then it would be clearer to the reader in my view.  A check for newline
is changed to a check for newline or nul-byte.

(Yes - I recognize that one is not given the freedom to change the
-old- lines in a patch for the sake of clarity ;).

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
