Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265339AbTLHFMD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 00:12:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265340AbTLHFMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 00:12:03 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:9708 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S265339AbTLHFMA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 00:12:00 -0500
Date: Mon, 8 Dec 2003 10:40:37 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: James W McMechan <mcmechanjw@juno.com>
Cc: hugh@veritas.com, linux-kernel@vger.kernel.org, wli@holomorphy.com,
       viro@parcelfarce.linux.theplanet.co.uk, akpm@osdl.org
Subject: Re: Oops with tmpfs on both 2.4.22 & 2.6.0-test11
Message-ID: <20031208051037.GB4667@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20031207.140732.-1654081.3.mcmechanjw@juno.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031207.140732.-1654081.3.mcmechanjw@juno.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 07, 2003 at 02:07:28PM -0800, James W McMechan wrote:
> After tinkering with patches for the last week I finally have a version
> that does not look quite so bad, my first attempts at improvement were
> awful in their awkwardness.
> The problem was that the cursor was in the list being walked, and when
> the pointer pointed to the cursor the list_del/list_add_tail pair would
> Oops trying to find the entry pointed to by the prev pointer of the
> freshly deleted cursor element.
> 
> The solution I finally found was to move the list_del earlier, before the
> beginning of the list walk, since it is not used during the list walk and
> should not count in the list enumeration it can be deleted, then the list
> pointer cannot point to it so it can be added safely with the
> list_add_tail
> without Oopsing, and everything works as expected I am unable to Oops
> this
> version with any of my test programs.
> 
> And of course since this Oops both 2.4 & 2.6 I will need to prepare
> a second set for the 2.4 tree.
> 
> My question to you who expressed interest, is anything odd looking about
> this code, anything that I am doing wrong or could do better?
> 

Looks better than my patch. The aim of dcache_dir_lseek() is to put the
cursor dentry at the required position and thats what it is doing now, deletes
the cursor, finds the desired location and then puts it there.

Thanks
Maneesh


-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-5044999 Fax: 91-80-5268553
T/L : 9243696
