Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932086AbVJCA1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbVJCA1S (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 20:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932087AbVJCA1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 20:27:18 -0400
Received: from nevyn.them.org ([66.93.172.17]:51859 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S932086AbVJCA1S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 20:27:18 -0400
Date: Sun, 2 Oct 2005 20:27:16 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: "Davda, Bhavesh P (Bhavesh)" <bhavesh@avaya.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] New SA_NOPRNOTIF sigaction flag
Message-ID: <20051003002716.GA5726@nevyn.them.org>
Mail-Followup-To: "Davda, Bhavesh P (Bhavesh)" <bhavesh@avaya.com>,
	linux-kernel@vger.kernel.org
References: <21FFE0795C0F654FAD783094A9AE1DFC086F0379@cof110avexu4.global.avaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21FFE0795C0F654FAD783094A9AE1DFC086F0379@cof110avexu4.global.avaya.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2005 at 01:11:22PM -0600, Davda, Bhavesh P (Bhavesh) wrote:
> How about 2 new PTRACE requests: PTRACE_SET_SIGIGN_MASK,
> PTRACE_GET_SIGIGN_MASK
> 
> Both taking a "sigset_t *mask" as a parameter? The mask would be filled
> by the debugger as usual using sigemptyset(), sigfillset(), sigaddset(),
> etc.
> 
> Of course, the implementation would do error checking for legal values
> of signals to mask, etc.
> 
> And this might require augmenting task_struct {} to store this mask,
> kind of like last_siginfo which is already used by the
> PTRACE_SETSIGINFO/PTRACE_GETSIGINFO ptrace requests.

Hmm, the only problem with this is that it requires consensus on the
format of kernel sigsets.  Think about the 32-vs-64-bit compatibility
issues.

It should be cleared on PTRACE_DETACH, of course.  Do we even need the
GET functionality?  If not, is PTRACE_SET_IGNORE_SIGNAL taking a single
signal number sufficient?

-- 
Daniel Jacobowitz
CodeSourcery, LLC
