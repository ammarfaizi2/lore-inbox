Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267459AbTB1Ens>; Thu, 27 Feb 2003 23:43:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267471AbTB1Ens>; Thu, 27 Feb 2003 23:43:48 -0500
Received: from bi-01pt1.bluebird.ibm.com ([129.42.208.186]:63823 "EHLO
	bigbang.in.ibm.com") by vger.kernel.org with ESMTP
	id <S267459AbTB1Enr>; Thu, 27 Feb 2003 23:43:47 -0500
Date: Fri, 28 Feb 2003 10:37:00 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Andrew Morton <akpm@digeo.com>, Dipankar Sarma <dipankar@in.ibm.com>,
       trond.myklebust@fys.uio.no, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Oops in rpc_depopulate with 2.5.62
Message-ID: <20030228050700.GA1134@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <25140000.1045901377@[10.10.2.4]> <20030222004930.0240738b.akpm@digeo.com> <20030224121442.GA1103@in.ibm.com> <7620000.1046277387@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7620000.1046277387@[10.10.2.4]>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2003 at 08:36:29AM -0800, Martin J. Bligh wrote:
> 
> This seems to fix the problem. No idea what it's doing, but it works ;-)
> 
> M.
Hi Martin,

Trond has the correct fix for this. The patch is as follows:

--- linux-2.5.61-up/net/sunrpc/clnt.c.orig      2003-02-15 21:05:02.000000000
++0100
+++ linux-2.5.61-up/net/sunrpc/clnt.c   2003-02-17 19:39:20.000000000 +0100
@@ -208,7 +208,8 @@
                rpcauth_destroy(clnt->cl_auth);
                clnt->cl_auth = NULL;
        }
-       rpc_rmdir(clnt->cl_pathname);
+       if (clnt->cl_pathname[0])
+               rpc_rmdir(clnt->cl_pathname);
        if (clnt->cl_xprt) {
                xprt_destroy(clnt->cl_xprt);
                clnt->cl_xprt = NULL;

Regards,
Maneesh


-- 
Maneesh Soni
IBM Linux Technology Center, 
IBM India Software Lab, Bangalore.
Phone: +91-80-5044999 email: maneesh@in.ibm.com
http://lse.sourceforge.net/
