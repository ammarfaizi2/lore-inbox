Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263268AbTJQAYq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 20:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263269AbTJQAYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 20:24:46 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:60273 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S263268AbTJQAYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 20:24:45 -0400
To: Chris Lattner <sabre@nondot.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [x86] Access off the bottom of stack causes a segfault?
References: <Pine.LNX.4.44.0310141320020.3869-100000@nondot.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 16 Oct 2003 18:23:26 -0600
In-Reply-To: <Pine.LNX.4.44.0310141320020.3869-100000@nondot.org>
Message-ID: <m1ismoempt.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Lattner <sabre@nondot.org> writes:

> My compiler is generating accesses off the bottom of the stack (address
> below %esp).  Is there some funny kernel interaction that I should be
> aware of with this?  I'm periodically getting segfaults.

Beyond the signal thing.  You are using a demand grown vma for the
stack, and using it past where it has grown.  If you grow the vma
deliberately you can use more of it.  But using more area than
you have allocated for the stack is most certainly a bug.


Eric
