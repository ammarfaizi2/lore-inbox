Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318804AbSICPR6>; Tue, 3 Sep 2002 11:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318806AbSICPR6>; Tue, 3 Sep 2002 11:17:58 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:37302 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S318804AbSICPR4>; Tue, 3 Sep 2002 11:17:56 -0400
Date: Tue, 3 Sep 2002 11:22:29 -0400
To: Anton Altaparmakov <aia21@cantab.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BK-PATCH-2.5] Introduce new VFS inode cache lookup function
Message-ID: <20020903152228.GB9903@ravel.coda.cs.cmu.edu>
Mail-Followup-To: Anton Altaparmakov <aia21@cantab.net>,
	linux-kernel@vger.kernel.org
References: <20020903035745.GG29452@ravel.coda.cs.cmu.edu> <Pine.SOL.3.96.1020903055423.13331A-100000@libra.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOL.3.96.1020903055423.13331A-100000@libra.cus.cam.ac.uk>
User-Agent: Mutt/1.4i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2002 at 06:20:44AM +0100, Anton Altaparmakov wrote:
> 2) It will return inodes that are I_FREEING or I_CLEAR. I will have to
> test for these in NTFS and then iput() to wash my hands clean of such
> garbage. And if I am not mistaken, the iput() actually will BUG().

If that is the case iget is broken. Perhaps it should test for these
states in find_inode (and find_inode_fast) and never return them. Are
those types of inodes still on the inode hash?

> 4) If anything, as Christoph Hellwig suggested to me on #kernel,
> iget{,5}_locked() should be reimplemented in terms of my ilookup()
> implementation and not vice versa. (-:

Well, considering that this function (modulo the I_FREEING|I_CLEAR test
is identical to the first 10 lines in iget5_locked, this could call that
function. Ofcourse iget_locked is using the 'fast' version of find_inode.

Jan
