Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263147AbUDWAv4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263147AbUDWAv4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 20:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263364AbUDWAv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 20:51:56 -0400
Received: from adsl-209-204-138-32.sonic.net ([209.204.138.32]:33667 "EHLO
	server.home") by vger.kernel.org with ESMTP id S263147AbUDWAvy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 20:51:54 -0400
Date: Thu, 22 Apr 2004 17:51:53 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@server.home
To: Urban Widmark <urban@teststation.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: CIFS/SMBFS failing under load in 2.6.X
In-Reply-To: <Pine.LNX.4.44.0404221935090.32465-100000@cola.local>
Message-ID: <Pine.LNX.4.58.0404221750070.14856@server.home>
References: <Pine.LNX.4.44.0404221935090.32465-100000@cola.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well the server is under very high load in this test (up to 200) and the
response times are also extremely high. Are timeouts new in 2.6.x? SMBFS
in 2.4.X does not seem to timeout.

Also are there any fixes for the 4KB size limitation? Windows allows 64K
writes and reads in one request. SMBFS only 4K.

On Thu, 22 Apr 2004, Urban Widmark wrote:

> On Mon, 12 Apr 2004, Christoph Lameter wrote:
>
> > Whenever I put a high load on CIFS or SMBFS requests timeout and then the
> > benchmark or whatever I run fails. I ran the same tests successfully with
> > a 2.4.25 kernel. This is a connection to a samba 3.0.2 server.
> >
> > SMBFS logs the following:
> >
> > Apr 12 15:59:25 testbox kernel: smb_add_request: request [ca7b7280,
> > mid=12891] timed out!
> > Apr 12 15:59:25 testbox kernel: smb_writepage_sync: failed write,
> > wsize=4096, result=-5
> ...
>
> > CIFS logs:
> >
> > Apr 12 17:02:00 testbox kernel:  CIFS VFS: Send error in write = -6
> > Apr 12 17:02:29 testbox kernel:  CIFS VFS: Send error in write = -5
> > Apr 12 17:02:29 testbox last message repeated 8 times
> > Apr 12 17:02:39 testbox kernel:  CIFS VFS: Need to reconnect after session
> > died to server
>
> smbfs and cifs does not share any code although I believe both of them
> will send multiple requests in parallel. Any chance that this is the
> server or network?
>
>
> smbfs at least does not limit the number of requests it sends. It could be
> a problem if the server has a low limit (should be the maxmux field in the
> smb_conn_opt struct).
>
> I could send a patch for this, but unless cifs does the same then that is
> probably not it.
>
> /Urban
>
>
