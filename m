Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262788AbTK3TVo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 14:21:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262838AbTK3TVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 14:21:44 -0500
Received: from cafe.hardrock.org ([142.179.182.80]:54912 "EHLO
	cafe.hardrock.org") by vger.kernel.org with ESMTP id S262788AbTK3TVm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 14:21:42 -0500
Date: Sun, 30 Nov 2003 12:21:33 -0700 (MST)
From: James Bourne <jbourne@hardrock.org>
To: linux-kernel@vger.kernel.org, <coreteam@netfilter.org>
Subject: 2.4.23/others and ip_conntrack causing hangs
Message-ID: <Pine.LNX.4.44.0311301204520.2148-100000@cafe.hardrock.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
I wanted to bring up an issue with ip_conntrack in 2.4.23, 2.4.22, and at
least 2.4.21 (sorry, didn't try 2.4.20).

The issue is that as long as there are connections being tracked, the
ip_conntrack module will not unload.  I can understand why this might be,
but the problem is that ip_conntrack will hang rmmod and modprobe -r until
such time as all the connections have been closed.

I think we need something like an ip_conntrack_flush or else completely drop
the connections when the module is unloaded (as previously done) as this
becomes an issue for people who need to drop their ip_tables and reload the
modules (perhaps to correct other issues) especially ip_conntrack...  

The only way to reload the modules right now (yes, I know removing modules
from a running kernel is dodgey anyway) is to completely drop the network
interfaces which kills off the connections *anyway*.  So, dropping the
connections shouldn't be an issue.

Thanks for the consideration.

Regards
James

-- 
James Bourne                  | Email:            jbourne@hardrock.org          
Unix Systems Administrator    | WWW:           http://www.hardrock.org
Custom Unix Programming       | Linux:  The choice of a GNU generation
----------------------------------------------------------------------
 "All you need's an occasional kick in the philosophy." Frank Herbert  

