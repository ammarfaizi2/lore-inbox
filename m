Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267553AbUHTTim@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267553AbUHTTim (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 15:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268667AbUHTTim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 15:38:42 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:15803 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267553AbUHTTid (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 15:38:33 -0400
Date: Fri, 20 Aug 2004 14:36:35 -0500
From: Maneesh Soni <maneesh@in.ibm.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, hawkes@sgi.com,
       linux-kernel@vger.kernel.org, wli@holomorphy.com
Subject: Re: kernbench on 512p
Message-ID: <20040820193635.GA4161@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <200408191216.33667.jbarnes@engr.sgi.com> <253460000.1092939952@flay> <200408191711.04776.jbarnes@engr.sgi.com> <200408191724.04422.jbarnes@engr.sgi.com> <270470000.1092952599@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <270470000.1092952599@flay>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2004 at 02:56:39PM -0700, Martin J. Bligh wrote:
> --On Thursday, August 19, 2004 17:24:04 -0400 Jesse Barnes <jbarnes@engr.sgi.com> wrote:
> 
> > On Thursday, August 19, 2004 5:11 pm, Jesse Barnes wrote:
> >> The output is attached (my mailer insists on wrapping it if I inline it). 
> >> I used 'lockstat -w'.
> > 
> > The highlights:
> > 
> >  nw   spin   rjct  lock & function
> > 19.0% 81.0%    0%  dcache_lock
> >  3.3% 96.7%    0%    d_alloc+0x270
> >  2.7% 97.3%    0%    d_delete+0x40
> > 18.3% 81.7%    0%    d_instantiate+0x90
> >  4.7% 95.3%    0%    d_move+0x60
> > 34.6% 65.4%    0%    d_rehash+0xe0
> > 19.1% 80.9%    0%    dput+0x40
> > 10.5% 89.5%    0%    link_path_walk+0xef0
> >    0%  100%    0%    sys_getcwd+0x210
> > 
> > 41.4% 58.6%    0%  rcu_state
> > 61.3% 38.7%    0%    __rcu_process_callbacks+0x260
> > 41.4% 58.6%    0%    rcu_check_quiescent_state+0xf0
> > 
> > So it looks like the dcache lock is the biggest problem on this system with 
> > this load.  And although the rcu stuff has improved tremendously for this 
> > system, it's still highly contended.
> 
> Hmmm. dcache_lock is known-fucked, though I'm suprised at d_rehash
> (file deletion)?
> 

The thing which is hurting most is dput(), almost 90% of the dcache_lock 
aquistion is there.

(deleted few columns)

 23.8% 67.3%     9955785 32.7% 67.3%    0%  dcache_lock
 0.06% 70.5%       17068 29.5% 70.5%    0%    d_alloc+0x270
 0.02% 25.4%       15340 74.6% 25.4%    0%    d_delete+0x40
 0.06% 65.9%       30485 34.1% 65.9%    0%    d_instantiate+0x90
 0.06% 78.0%        4461 22.0% 78.0%    0%    d_move+0x60
 0.00%    0%           2  100%    0%    0%    d_path+0x120
 0.04% 52.5%       17068 47.5% 52.5%    0%    d_rehash+0xe0
 0.00% 26.7%          15 73.3% 26.7%    0%    d_splice_alias+0xc0
 0.00% 20.0%           5 80.0% 20.0%    0%    dentry_unhash+0x70
 0.00%    0%           4  100%    0%    0%    dentry_unhash+0xc0
 23.5% 67.5%     9827270 32.5% 67.5%    0%    dput+0x40
 0.09% 62.3%       36875 37.7% 62.3%    0%    link_path_walk+0xef0
 0.00% 0.24%        5068 99.8% 0.24%    0%    link_path_walk+0x1cc0
 0.00% 33.3%           3 66.7% 33.3%    0%    proc_pid_unhash+0x50
 0.00%  7.1%          14 92.9%  7.1%    0%    prune_dcache+0x50
 0.00%    0%         167  100%    0%    0%    prune_dcache+0x3d0
 0.00%    0%          21  100%    0%    0%    select_parent+0x40
 0.00% 24.2%        1919 75.8% 24.2%    0%    sys_getcwd+0x210



-- 
Maneesh Soni
Linux Technology Center, 
IBM Austin
email: maneesh@in.ibm.com
Phone: 1-512-838-1896 Fax: 
T/L : 6781896
