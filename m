Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262166AbUKQCZl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262166AbUKQCZl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 21:25:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262167AbUKQCXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 21:23:53 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:63978
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262168AbUKQCWQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 21:22:16 -0500
Date: Tue, 16 Nov 2004 18:07:18 -0800
From: "David S. Miller" <davem@davemloft.net>
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: loops in get_user_pages() for VM_IO
Message-Id: <20041116180718.2fa35fbb.davem@davemloft.net>
In-Reply-To: <20041116175328.5e425e01.davem@davemloft.net>
References: <20041116175328.5e425e01.davem@davemloft.net>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Nov 2004 17:53:28 -0800
"David S. Miller" <davem@davemloft.net> wrote:

> Some time recently, I don't know when, the logic in get_user_pages()
> appears to have been changed a bit.

Replying to myself, this hang started when do_mmap_pgoff() was
changed to re-read the vma->vm_flags bits right before we
vma_link() the vma into the mm.

Previously, only the mmap() call specified vm_flags would
be used, but now we also get whatever bit changes to
vma->vm_flags are done by the file->f_op->mmap() method
as well.

In any event, it is still an open question whether get_user_pages()
and thus make_pages_present() is meant to be able to handle
VM_IO areas.
