Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265936AbTAOIlS>; Wed, 15 Jan 2003 03:41:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265982AbTAOIlS>; Wed, 15 Jan 2003 03:41:18 -0500
Received: from mailout09.sul.t-online.com ([194.25.134.84]:715 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S265936AbTAOIlR>; Wed, 15 Jan 2003 03:41:17 -0500
To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Changes to the LSM file-related hooks for 2.5.58
References: <20030114191012$4fb6@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: 15 Jan 2003 09:49:48 +0100
In-Reply-To: <20030114191012$4fb6@gated-at.bofh.it>
Message-ID: <m3fzrusspf.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Stephen D. Smalley" <sds@epoch.ncsc.mil> writes:
> 
> 3) Add a security_file_alloc call to init_private_file and create a
> release_private_file function to encapsulate release of private file
> structures.  These changes ensure that security structures for private
> files will be allocated and freed appropriately.

Adding release_private_file requires fixing all code that uses 
init_private_file (including possible third party code). Otherwise
you have some subtle leak. It would better to rename init_private_file to
some other name and add appropiate comments so that this can be catched 
easily at compile time.

-Andi
