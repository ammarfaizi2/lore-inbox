Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267777AbUJDIPT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267777AbUJDIPT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 04:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267785AbUJDIPT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 04:15:19 -0400
Received: from sklave3.rackland.de ([213.133.101.23]:52712 "EHLO
	sklave3.rackland.de") by vger.kernel.org with ESMTP id S267777AbUJDIPL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 04:15:11 -0400
From: Hadmut Danisch <hadmut@danisch.de>
Date: Mon, 4 Oct 2004 10:11:30 +0200
To: "P. Benie" <pjb1008@eng.cam.ac.uk>
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: NFS incompatible with Solaris jumpstart
Message-ID: <20041004081130.GA17971@danisch.de>
References: <Pine.HPX.4.58L.0410040041270.2874@punch.eng.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.HPX.4.58L.0410040041270.2874@punch.eng.cam.ac.uk>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2004 at 01:10:46AM +0100, P. Benie wrote:
> Re your jumpstart problem - a colleague in another department had trouble
> with this once. I don't think he had the time to fix the problem.
> 
> He did get as far as finding that the client got an error from the NFS
> server when accessing /dev/console. This would give the impression of
> hanging as soon as the kernel starts init. It should be easy to verify if
> you have the same problem using tcpdump.


/dev/ was a good hint. I found the problem:

When booting the Solaris system wants to write to the 
Boot environment (nasty, isn't it?).

Since the userspace daemon doesn't understand the /etc/exports syntax
of the kernel version, I wrote a different, simplified /etc/exports
for the userspace daemon. 

The userspace daemon allowed write access, the kernel version didn't. 
That was the problem.

regards
Hadmut
