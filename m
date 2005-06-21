Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262266AbVFUTqK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262266AbVFUTqK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 15:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262285AbVFUTqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 15:46:05 -0400
Received: from graphe.net ([209.204.138.32]:1955 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S262270AbVFUToV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 15:44:21 -0400
Date: Tue, 21 Jun 2005 12:44:14 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Robert Love <rml@novell.com>
cc: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: -mm -> 2.6.13 merge status
In-Reply-To: <1119382685.3949.263.camel@betsy>
Message-ID: <Pine.LNX.4.62.0506211239540.22040@graphe.net>
References: <20050620235458.5b437274.akpm@osdl.org>  <42B831B4.9020603@pobox.com>
 <1119368364.3949.236.camel@betsy>  <Pine.LNX.4.62.0506211222040.21678@graphe.net>
 <1119382685.3949.263.camel@betsy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jun 2005, Robert Love wrote:

> On Tue, 2005-06-21 at 12:22 -0700, Christoph Lameter wrote:
> 
> > I noticed that select() is not working on real files. Could inotify 
> > be used to fix select()?
> 
> Select the system call?  It should work fine.   ;-)

Hmmm. I just wrote an app that uses select to do essentially a "tail" 
waiting for new content in a log file. The file descriptors for real disk 
files are always ready even if there is no content available for the 
application.

The file is positioned at the end of the file after open via lseek.
select tells me that data is available but the read() returns zero bytes.

The current fix on the app level is to checking if useful work was 
done as a result of "READY" file descriptors. If the read() operations
do not return any data then the app will simply sleep for a couple of 
seconds. So the app degenerates to a kind of poll mode if disk files are 
used.


