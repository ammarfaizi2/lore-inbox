Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262822AbULRCjq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262822AbULRCjq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 21:39:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262823AbULRCjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 21:39:46 -0500
Received: from thunk.org ([69.25.196.29]:56779 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S262822AbULRCjf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 21:39:35 -0500
Date: Fri, 17 Dec 2004 21:39:29 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Bhattiprolu, Ravikumar (Ravikumar)" <ravikb@agere.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Magic Number for New File system
Message-ID: <20041218023929.GB19699@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	"Bhattiprolu, Ravikumar (Ravikumar)" <ravikb@agere.com>,
	linux-kernel@vger.kernel.org
References: <6E1F4DB94568BB4AA8A30083E67378924BB67C@iiex2ku01.agere.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6E1F4DB94568BB4AA8A30083E67378924BB67C@iiex2ku01.agere.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2004 at 11:42:48AM +0530, Bhattiprolu, Ravikumar (Ravikumar) wrote:
> 
> We are planning to write a new file system for our requirements. Is
> there any standard way to allocate a magic number for this new file
> system? Also how to go about writing the new file system?

There's no standard place to put a magic number, let alone a standard
way to generate a magic number.... that being said, I'd suggest an 8
character field that contains the ascii name of your filesystem plus a
format version number at the beginning of the superblock.  The
location of the superblock will vary from filesystem to filesystem,
but most mkfs program will zero the first 4-8k at the beginning and
end of the device in order to prevent false recognition by programs
trying to ID the device looking for magic numbers in various different
locations.

The blkid library, contained in the e2fsprogs distribution, contains a
list of magic number and their locations used by various different
filesystems, if you'd like to take a look at that for some more
information.

						- Ted
