Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264628AbUFTAUh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264628AbUFTAUh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 20:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264777AbUFTAUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 20:20:37 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:28454 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S264628AbUFTAUg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 20:20:36 -0400
Date: Sun, 20 Jun 2004 01:20:25 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Stas Sergeev <stsp@aknet.ru>
cc: Andrew Morton <akpm@osdl.org>, Christoph Rohland <cr@sap.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch][rfc] expandable anonymous shared mappings
In-Reply-To: <40D4023E.8010500@aknet.ru>
Message-ID: <Pine.LNX.4.44.0406200048490.29576-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Jun 2004, Stas Sergeev wrote:
> Hugh Dickins wrote:
> > shared anonymous only becomes interesting when you fork.

> I disagree with this. The way I am using it may look horrible,
> but yes, I do use it without the fork().

Then I think you have no reason to use MAP_SHARED: use MAP_PRIVATE
and you should get the behaviour you require, without kernel change.

Shared anonymous is peculiar: although mapping is anonymous (nothing
shared with unrelated mms), modifications are shared between parent
and children.  It's half-way between anonymous and file-backed.

We agree that it might be nice to let the object used to support that
be extended if mremap extends the mapping.  But it might instead just
be needless feature creep.  Sorry, your case does not persuade me yet.

Hugh

