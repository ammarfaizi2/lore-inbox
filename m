Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932130AbWCMLmu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbWCMLmu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 06:42:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751940AbWCMLmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 06:42:50 -0500
Received: from mx1.redhat.com ([66.187.233.31]:18860 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751920AbWCMLmt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 06:42:49 -0500
Message-ID: <44155A7E.4030804@RedHat.com>
Date: Mon, 13 Mar 2006 06:41:50 -0500
From: Steve Dickson <SteveD@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: NeilBrown <neilb@suse.de>
CC: Andrew Morton <akpm@osdl.org>, nfs@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [NFS] [PATCH 000 of 14] knfsd: Introduction
References: <20060309174755.24381.patches@notabene>
In-Reply-To: <20060309174755.24381.patches@notabene>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NeilBrown wrote:
> The following series of patches changes the code for lookup up
> authentication/authorisation caches in sunrpc as used by nfsd.  That
> than having a delightful macro that defines a function of a particular
> type of cache, the functions are coded on a more traditional manner
> using library routines.
> 
> This will hopefully make the code more maintainable.
After looking over these patches, it appears there two 'minor'
things missing... comments and dprintk statements... :-)
Maybe I missed them, but out of all these 14 patches (i.e. basically
rewriting a critical part of kNFSD) not one comment or dprintk
as added....

Now I'm sure this is a much better design that the previous one,
(i.e. hide sight is always 20/20) and I'm looking forward to
help iron out the nits... But without meaningful comments and a way
to turn on a _few_ well placed "I failed here" type of debug
messages, the design really doesn't matter since the maintainable
has not improved... imho...

Secondly,  In a number of places, mostly in the alloc routines and in
patch 006 there are if statements like:

+	if (ch)
+		return container_of(ch, struct svc_export, h);
+	else
+		return NULL;
the else is simply not needed... Plus adding a dprintk like:

+	if (ch)
+		return container_of(ch, struct svc_export, h);
+	
+	dprintk("svc_export_update: returns NULL\n");
+	return NULL;
might make sense... assuming svc_export_update does not return NULL
99% of the time...

steved.




