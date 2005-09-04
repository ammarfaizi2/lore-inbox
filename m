Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751321AbVIDJUf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbVIDJUf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 05:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbVIDJUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 05:20:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60612 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751313AbVIDJUe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 05:20:34 -0400
Date: Sun, 4 Sep 2005 02:18:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: phillips@istop.com, linux-cluster@redhat.com, wim.coekaerts@oracle.com,
       linux-fsdevel@vger.kernel.org, ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [Linux-cluster] Re: GFS, what's remaining
Message-Id: <20050904021836.4d4560a5.akpm@osdl.org>
In-Reply-To: <20050904091118.GZ8684@ca-server1.us.oracle.com>
References: <20050901104620.GA22482@redhat.com>
	<200509040022.37102.phillips@istop.com>
	<20050903214653.1b8a8cb7.akpm@osdl.org>
	<200509040240.08467.phillips@istop.com>
	<20050904002828.3d26f64c.akpm@osdl.org>
	<20050904080102.GY8684@ca-server1.us.oracle.com>
	<20050904011805.68df8dde.akpm@osdl.org>
	<20050904091118.GZ8684@ca-server1.us.oracle.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Becker <Joel.Becker@oracle.com> wrote:
>
> 	I can't see how that works easily.  I'm not worried about a
>  tarball (eventually Red Hat and SuSE and Debian would have it).  I'm
>  thinking about this shell:
> 
>  	exec 7</dlm/domainxxxx/lock1
>  	do stuff
>  	exec 7</dev/null
> 
>  If someone kills the shell while stuff is doing, the lock is unlocked
>  because fd 7 is closed.  However, if you have an application to do the
>  locking:
> 
>  	takelock domainxxx lock1
>  	do sutff
>  	droplock domainxxx lock1
> 
>  When someone kills the shell, the lock is leaked, becuase droplock isn't
>  called.  And SEGV/QUIT/-9 (especially -9, folks love it too much) are
>  handled by the first example but not by the second.


	take-and-drop-lock -d domainxxx -l lock1 -e "do stuff"
