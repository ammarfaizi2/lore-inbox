Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751116AbWC0QwC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbWC0QwC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 11:52:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751113AbWC0QwB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 11:52:01 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:23276 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751094AbWC0QwA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 11:52:00 -0500
Date: Mon, 27 Mar 2006 10:52:08 -0600
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: James Morris <jmorris@namei.org>
Cc: Andrew Morton <akpm@osdl.org>, phillip@hellewell.homeip.net,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       viro@ftp.linux.org.uk, mike@halcrow.us, mcthomps@us.ibm.com,
       yoder1@us.ibm.com, toml@us.ibm.com, emilyr@us.ibm.com,
       daw@cs.berkeley.edu
Subject: Re: eCryptfs Design Document
Message-ID: <20060327165208.GA14817@us.ibm.com>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
References: <20060324222517.GA13688@us.ibm.com> <Pine.LNX.4.64.0603241757090.27964@excalibur.intercode>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0603241757090.27964@excalibur.intercode>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2006 at 06:12:46PM -0500, James Morris wrote:
> What about other attacks on MD5?

The only attacks that I am aware of against MD5 require known prefix
values, and all of the prefix values in eCryptfs are secret.

> Hard coding it into the system makes me nervous, what about making
> this selectable?

This is yet another attribute that we would like to include in policy
support in future versions of eCryptfs. There are many things we could
have made parameterizable in release 0.1, but we decided to just lock
it down to a single hash algorithm, cipher/key size, chaining mode,
and so forth. Once eCryptfs has been weathered in its current state,
we would like to incrementally start allowing more flexibility in
these cryptographic attributes on a step-by-step basis.

Those who reviewed the design document did express concern over the
fact that we are using MD5, simply because of the known-prefix
attacks, but up to now, based on what is known about the cryptographic
properties of the hash algorithms, nobody has presented a reason why
using something like SHA-256 or RIPEMD-160 for either the S2K
operation or the root IV generation would make eCryptfs any more
secure than it currently is.

> > By default, eCryptfs selects AES-128. Later versions of eCryptfs
> > will allow the user to select the cipher and key length.
> 
> Also, what about making the encryption mode selectable, to at least
> allow for like LRW support in addition to CBC?

That also is another feature that we would like to defer for a future
release. Changing the chaining mode may have security implications,
and so we would prefer to think through how that feature can be
intelligently offered to the user. For instance, we would not want a
user to just be able to blindly select ECB mode, which he might
naively do if he finds that it helps performance.

Thanks,
Mike
