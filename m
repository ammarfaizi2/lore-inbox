Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267385AbUG2AdH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267385AbUG2AdH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 20:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267376AbUG2AaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 20:30:25 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48530 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267395AbUG2A32
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 20:29:28 -0400
Date: Thu, 29 Jul 2004 01:29:24 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: "David S. Miller" <davem@redhat.com>
Cc: Chris Wedgwood <cw@f00f.org>, peter@chubb.wattle.id.au,
       linux-kernel@vger.kernel.org
Subject: Re: stat very inefficient
Message-ID: <20040729002924.GK12308@parcelfarce.linux.theplanet.co.uk>
References: <233602095@toto.iv> <16648.10711.200049.616183@wombat.chubb.wattle.id.au> <20040728154523.20713ef1.davem@redhat.com> <20040729000837.GA24956@taniwha.stupidest.org> <20040728171414.5de8da96.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040728171414.5de8da96.davem@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2004 at 05:14:14PM -0700, David S. Miller wrote:
> On Wed, 28 Jul 2004 17:08:37 -0700
> Chris Wedgwood <cw@f00f.org> wrote:
> 
> > Just How bad is it for you?  I just tested stat on my crapbox and for
> > a short path 1M stats takes 0.5s and for a longer path (30 bytes or
> > so) 2.8s.
> 
> Run "time find . -type f" on the kernel tree, both before and
> after removing the third unnecessary copy.

... with hot cache, otherwise IO time will dominate.  I don't disagree
with you, but in all realistic cases I can think of it's going to be
noise (e.g. this find over kernel tree is almost certainly followed
by xargs grep, etc.).
