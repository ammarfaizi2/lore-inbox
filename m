Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262048AbTJSTDa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 15:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262069AbTJSTDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 15:03:30 -0400
Received: from holomorphy.com ([66.224.33.161]:23170 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262048AbTJSTD2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 15:03:28 -0400
Date: Sun, 19 Oct 2003 12:01:21 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, davidm@hpl.hp.com, bjorn.helgaas@hp.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] prevent "dd if=/dev/mem" crash
Message-ID: <20031019190121.GA1215@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Andrew Morton <akpm@osdl.org>, davidm@hpl.hp.com,
	bjorn.helgaas@hp.com, linux-ia64@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <200310171610.36569.bjorn.helgaas@hp.com> <20031017155028.2e98b307.akpm@osdl.org> <200310171725.10883.bjorn.helgaas@hp.com> <20031017165543.2f7e9d49.akpm@osdl.org> <16272.34681.443232.246020@napali.hpl.hp.com> <20031017174955.6c710949.akpm@osdl.org> <m1llrh79la.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1llrh79la.fsf@ebiederm.dsl.xmission.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 19, 2003 at 05:25:37AM -0600, Eric W. Biederman wrote:
> We do have all of the information we need in struct page to see if a
> page address is valid, so checking that is reasonable.  I suspect it
> will require some interesting variant of pfn_to_page to handle of the
> weird sparse memory locations properly.

It would be best to check the pfn before attempting to convert it to a
struct page. The struct page * returned by arch code will be garbage in
most instances, as none of the routines actually check validity
internally. pfn_valid() is even bogus on most of them, so you'll have
to walk pgdats by hand for this. The pfn_valid() checks work most of the
time on PC's, but the first time someone runs X on a box with discontig
and a bogus pfn_valid() they'll get fireworks (and in fact, it's already
happened, but wasn't posted to lkml).


-- wli
