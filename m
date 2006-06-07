Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932330AbWFGQ4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330AbWFGQ4a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 12:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932331AbWFGQ4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 12:56:30 -0400
Received: from mx1.redhat.com ([66.187.233.31]:65169 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932330AbWFGQ43 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 12:56:29 -0400
Message-ID: <44870532.2010902@redhat.com>
Date: Wed, 07 Jun 2006 12:56:18 -0400
From: Peter Staubach <staubach@redhat.com>
User-Agent: Mozilla Thunderbird 1.0.8-1.4.1 (X11/20060420)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "J. Bruce Fields" <bfields@fieldses.org>
CC: Neil Brown <neilb@suse.de>, NFS List <nfs@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: [NFS] [PATCH] NFS server does not update mtime on setattr request
References: <4485C3FE.5070504@redhat.com> <1149658707.27298.10.camel@localhost> <4486E662.5080900@redhat.com> <20060607151754.GB23954@fieldses.org> <4486F020.3030707@redhat.com> <20060607154258.GA22335@fieldses.org> <4486F5C7.60606@redhat.com> <20060607160334.GB22335@fieldses.org>
In-Reply-To: <20060607160334.GB22335@fieldses.org>
Content-Type: multipart/mixed;
 boundary="------------020506000201050800080408"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020506000201050800080408
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

J. Bruce Fields wrote:

>On Wed, Jun 07, 2006 at 11:50:31AM -0400, Peter Staubach wrote:
>  
>
>>The Red Hat BZ number is 193621.
>>    
>>
>
>"You are not authorized to access bug #193621", it tells me....
>
>  
>

Hmm.  That ones seems to be restricted for some reason.  I think that
this happens when we get escalated bugzillas from customers.


>>The description is that when zero length files are copied, even over
>>an existing zero length file, the mtime on the target file does not
>>change.
>>    
>>
>
>Is the server-side patch sufficient on its own?
>  
>

The server side patch isn't quite sufficient on its own.  A RHEL-4 patch
is also required for the client side.  I could construct the RHEL-4 patch
so that it alone would be sufficient to address the particular problem
that that customer is having, but that isn't the entire situation.
Non-Linux clients would still have a problem with the current upstream
Linux server.  For example, in my testing, a Solaris 10 client mounting
an FC-5 server fails.  When running the attached script, the mtime on
the file, bar, should change by about 1 minute, 3 times.

    Thanx...

       ps

--------------020506000201050800080408
Content-Type: text/plain;
 name="repo"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="repo"

#!/bin/sh

rm -f foo bar

set -x

touch foo

cp foo bar

stat --format="%n %y" foo bar

sleep 60

cp foo bar

stat --format="%n %y" foo bar

sleep 60

cp foo bar

stat --format="%n %y" foo bar

sleep 60

rm foo

touch foo

cp foo bar

stat --format="%n %y" foo bar

--------------020506000201050800080408--
