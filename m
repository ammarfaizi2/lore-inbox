Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263386AbTDGLm1 (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 07:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263387AbTDGLm1 (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 07:42:27 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:32492 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id S263386AbTDGLm1 (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 07:42:27 -0400
Date: Mon, 7 Apr 2003 12:55:59 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Christoph Rohland <cr@sap.com>
cc: =?iso-8859-1?q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       CaT <cat@zip.com.au>, <tomlins@cam.org>, <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: allow percentile size of tmpfs (2.5.66 / 2.4.20-pre2)
In-Reply-To: <ov65pqlnb9.fsf@sap.com>
Message-ID: <Pine.LNX.4.44.0304071245130.1130-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Apr 2003, Christoph Rohland wrote:
> On Wed, 2 Apr 2003, Hugh Dickins wrote:
> > Don't blame Christoph for that, one of these days I'll face up to
> > my responsibilities and make swapoff fail (probably get itself
> > OOM-killed) instead of having everything else OOM-killed.
> 
> The hooks for the accounting would solve this easily: the swapoff hook
> would realize that there is not enough space left for the tmpfs
> instance and simply return an error. So swapoff would fail.
> We would not even stress the vm to swapin all pages until
> realizingthat there is not enough memory left.

You're supposing that it's tmpfs causing this problem: not at all,
that's just an easy way to show it.  Take away tmpfs, and swapoff
is still liable to hang, with other tasks OOMing (even when strict
no-overcommit accounting: I've not yet added the check it needs).

Hugh

