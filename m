Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262496AbUCHOo7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 09:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262497AbUCHOo7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 09:44:59 -0500
Received: from mx1.redhat.com ([66.187.233.31]:33724 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262496AbUCHOo5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 09:44:57 -0500
Date: Mon, 8 Mar 2004 09:45:39 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Jouni Malinen <jkmaline@cc.hut.fi>
cc: "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Crypto API and keyed non-HMAC digest algorithms / Michael MIC
In-Reply-To: <20040306184623.GB3963@jm.kir.nu>
Message-ID: <Xine.LNX.4.44.0403080935310.22156-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Mar 2004, Jouni Malinen wrote:

> Current Linux crypto API does not seem to have generic mechanism for
> adding keyed digest algorithms that are not using HMAC construction.
> IEEE 802.11i/WPA uses such an algorithm in TKIP and getting this to
> crypto API would be useful in order to be able to share more code of
> TKIP implementation.
> 
> One straightforward way of adding support for Michael MIC is to add an
> optional setkey operation for digest algorithms. The included patch
> (against Linux 2.6.4-rc2) does exactly this and also includes an
> implementation of Michael MIC. Another option would be to add a new
> algorithm type for keyed hash algorithms, but that seemed unnecessary
> for this purpose. Is the modification of digest type acceptable way of
> adding support for a keyed digest algorithm that does not use HMAC?

I think it would be better to do the latter, add another mode for 
simple keyed digest processing (KMAC?), where a function called something 
like kmac_init() takes the tfm/key/kelen paramters.  The kmac_update() and
kmac_final() methods are just wrappers around the digest methods, and we 
also kmac_kmac() similar to the HMAC method.

This would be a config option.

> The patch includes test vectors for Michael MIC and I have tested this
> with the Host AP driver and TKIP. Getting this into crypto API is one of
> the first steps in replacing the internal crypto algorithm
> implementation in the Host AP driver code and I would appreciate it if
> this would be applied to Linux 2.6 tree.

Is there an 802.11i spec available?  It seems like there are only drafts 
available which require payment.  I'd like to see the Micheal MIC 
algorithm description & know of any potential IP rights issues.

Also, is there any mainline kernel code which would use this feature?


- James
-- 
James Morris
<jmorris@redhat.com>


