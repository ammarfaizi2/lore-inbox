Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751191AbVLGQjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbVLGQjh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 11:39:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbVLGQjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 11:39:37 -0500
Received: from mx1.redhat.com ([66.187.233.31]:48876 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751191AbVLGQjg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 11:39:36 -0500
Message-ID: <4397103D.7050409@redhat.com>
Date: Wed, 07 Dec 2005 11:39:25 -0500
From: Peter Staubach <staubach@redhat.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.4.1 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: Kenny Simpson <theonetruekenny@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: another nfs puzzle
References: <20051206220448.82860.qmail@web34109.mail.mud.yahoo.com>	 <4396EB2F.3060404@redhat.com>	 <1133964667.27373.13.camel@lade.trondhjem.org> <4396EF50.30201@redhat.com>	 <1133966063.27373.29.camel@lade.trondhjem.org>	 <4397011E.9010703@redhat.com>	 <1133970117.27373.53.camel@lade.trondhjem.org>	 <4397063A.2030200@redhat.com> <1133971780.27373.64.camel@lade.trondhjem.org>
In-Reply-To: <1133971780.27373.64.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:

>
>I agree. It is clearly going to be a drag on performance, but it should
>be very much a corner case, so...
>
>  
>

Yes, file systems tend to mostly be about the corner cases though...  :-)

>To tell you the truth, I'm more interested in this case in order to
>figure out how to make mmap() work correctly for the case of an ordinary
>file, but where the file changes on the server. Currently we just call
>invalidate_inode_pages2(), without unmapping first. The conclusion from
>Kenny's testcase appears to be that this may lead to mmapped dirty data
>being lost.
>

Ugly, huh?  The options seem to be to either write out all of the data
to the server or just truncate it.  I have seen the former used mostly,
although this does generate the "last one there wins" scenario.  This
does match the usual semantics associated with normal cached data from
write(2)s and should fit well with the NFSv4 callback notifying that a
write delegation is being withdrawn.

    Thanx...

       ps
