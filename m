Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267401AbUG2BLv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267401AbUG2BLv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 21:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267400AbUG2BLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 21:11:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:16558 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267398AbUG2BJK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 21:09:10 -0400
Message-ID: <41084DBE.1070802@redhat.com>
Date: Wed, 28 Jul 2004 18:07:10 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a3) Gecko/20040728
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: Peter Chubb <peter@chubb.wattle.id.au>,
       viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Subject: Re: stat very inefficient
References: <233602095@toto.iv>	<16648.10711.200049.616183@wombat.chubb.wattle.id.au> <20040728154523.20713ef1.davem@redhat.com>
In-Reply-To: <20040728154523.20713ef1.davem@redhat.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:

> "find . -type f" is probably the most often run command somewhere
> in a shell pipeline [...]

I hope you're testing this on a recent system with a good find
implementation.  Nowadays find calls stat for this command line only for
directories and symlinks.  Those types along with normal files are all
known to find through the readdir calls (i.e., the d_type field).

Check your strace output to see whether your system is recent enough.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
