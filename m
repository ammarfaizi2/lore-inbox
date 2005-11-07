Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964846AbVKGPk2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964846AbVKGPk2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 10:40:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964847AbVKGPk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 10:40:28 -0500
Received: from EXCHG2003.microtech-ks.com ([65.16.27.37]:6843 "EHLO
	EXCHG2003.microtech-ks.com") by vger.kernel.org with ESMTP
	id S964846AbVKGPk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 10:40:27 -0500
From: "Roger Heflin" <rheflin@atipa.com>
To: "'Steven Timm'" <timm@fnal.gov>, <linux-kernel@vger.kernel.org>
Subject: RE: rpc-srv/tcp: nfsd: sent only -107 bytes (fwd)
Date: Mon, 7 Nov 2005 09:47:18 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Thread-Index: AcXf6EMJk8Lyz2ecRAiB8ozcVm4QegDyB06Q
In-Reply-To: <Pine.LNX.4.62.0511021405430.20925@snowball.fnal.gov>
Message-ID: <EXCHG2003o4lB4BwOZx000005bd@EXCHG2003.microtech-ks.com>
X-OriginalArrivalTime: 07 Nov 2005 15:35:26.0838 (UTC) FILETIME=[E064D160:01C5E3B0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Steven Timm
> Sent: Wednesday, November 02, 2005 2:06 PM
> To: linux-kernel@vger.kernel.org
> Subject: rpc-srv/tcp: nfsd: sent only -107 bytes (fwd)
> 
> 
> 
> I am seeing repeated errors of rpc-srv/tcp: nfsd: sent only 
> -107 bytes in the /var/log/messages of my machine.  Full 
> configuration info is below.  Only suggestion I have seen 
> thus far increase the number of nfsd that are running.  we 
> have done this, raising from 8 to 64, the problem persists.  
> Are there any other suggestions that could help this problem?
> 
> Thanks
> 

I have only seen this problem with large numbers of NFS clients, given
your address I suspect that would be the issue.

What kernel are you running?  I saw this issue on the 2.4 series, the
large 2.6 things we have built avoided using TCP given that we had
seen this issue.

There is a calculation someplace in nfs that determines how many of these
things exist, is is some base + so many per nfs thread.  If you 
search for message you have there are some posts on the NFS lists
about it that I made last year.

On the client side each separate mount against a server counts as
one, so if each client is mounting /opt and /home and /data and
you have 100 machines you need at least 300.

The solution that I came to was to use UDP mounts, as this limit
is not there.   In the situation I had we would have had to change
the number of nfsd to 256 and even that was going to be close, 
and the 256 caused some other failures.  To not have the issue you
will need to use UDP mounts everywere if you have enough tcp mounts
to cause the error it will affect the udp mounts in a similar bad way.

We also could have changed the thread to resource count, but we had
some other process starvation issue with TCP that seemed to not be
duplicatable with UDP.

                     Roger
                     Atipa Technologies

