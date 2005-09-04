Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932083AbVIDSD2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbVIDSD2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 14:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932074AbVIDSD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 14:03:27 -0400
Received: from wproxy.gmail.com ([64.233.184.203]:8578 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750971AbVIDSD1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 14:03:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ib7851Ghzt0zLVk+9mpn49KMI325xTNEtmU40cCdJDXkVPNRZGu2y/cafWWz8fuODduAUHc8HlwbnjXdYf76MkyjxGngr/ZAIO+lftPloQiykfFxZFIpTtODDBIzL93dKiR2FYmDJXoWCVPhXspmHSbmzQvlesfm3CMhSkfMCXk=
Message-ID: <924c288305090411038aa80f8@mail.gmail.com>
Date: Sun, 4 Sep 2005 11:03:21 -0700
From: Hua Zhong <hzhong@gmail.com>
To: linux clustering <linux-cluster@redhat.com>, Andrew Morton <akpm@osdl.org>,
       phillips@istop.com, wim.coekaerts@oracle.com,
       linux-fsdevel@vger.kernel.org, ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [Linux-cluster] Re: GFS, what's remaining
In-Reply-To: <20050904091118.GZ8684@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050901104620.GA22482@redhat.com>
	 <200509040022.37102.phillips@istop.com>
	 <20050903214653.1b8a8cb7.akpm@osdl.org>
	 <200509040240.08467.phillips@istop.com>
	 <20050904002828.3d26f64c.akpm@osdl.org>
	 <20050904080102.GY8684@ca-server1.us.oracle.com>
	 <20050904011805.68df8dde.akpm@osdl.org>
	 <20050904091118.GZ8684@ca-server1.us.oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>        takelock domainxxx lock1
>        do sutff
>        droplock domainxxx lock1
> 
> When someone kills the shell, the lock is leaked, becuase droplock isn't
> called.

Why not open the lock resource (or the lock space) instead of
individual locks as file? It then looks like this:

open lock space file
takelock lockresource lock1
do stuff
droplock lockresource lock1
close lock space file

Then if you are killed the ->release of lock space file should take
care of cleaning up all the locks
