Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264505AbRFMDJj>; Tue, 12 Jun 2001 23:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264506AbRFMDJa>; Tue, 12 Jun 2001 23:09:30 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:31973 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S264505AbRFMDJZ>;
	Tue, 12 Jun 2001 23:09:25 -0400
Date: Tue, 12 Jun 2001 23:09:23 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Neil Brown <neilb@cse.unsw.edu.au>
cc: John Covici <covici@ccs.covici.com>, linux-kernel@vger.kernel.org
Subject: Re: is there a way to export a fat32 file system using nfs?
In-Reply-To: <15142.55093.846398.117560@notabene.cse.unsw.edu.au>
Message-ID: <Pine.GSO.4.21.0106122304190.942-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 13 Jun 2001, Neil Brown wrote:

>    Call fat_iget(i_location).
>     If this finds something, check i_logstart. 
>     If it matches, assume SUCCESS.
> 
>    Then comes the tricky bit:  read the directory entry
>     indicated by i_location, check the i_logstart is right,
>     if it is, try to get it into the inode cache properly.

Uh-huh. Suppose that directory had been removed and space had been
reused by a regular file. Which had been filled with the right
contents. It's really not hard to do. Now, remove that file and
you've got a nice data corruption waiting to happen.

