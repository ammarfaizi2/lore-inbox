Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751386AbWINHPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386AbWINHPs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 03:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbWINHPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 03:15:48 -0400
Received: from ami.ga ([217.160.111.113]:55938 "HELO p15097255.pureserver.info")
	by vger.kernel.org with SMTP id S1751386AbWINHPq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 03:15:46 -0400
Date: Thu, 14 Sep 2006 09:15:45 +0200
From: Colin Hirsch <share-lkml@think42.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Error binding socket: address already in use
Message-ID: <20060914071545.GA28332@p15097255.pureserver.info>
Reply-To: mail@cohi.at
References: <1GNVuW-02KMfw0@fwd29.sul.t-online.de> <1158161015.13977.27.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1158161015.13977.27.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2006 at 04:23:35PM +0100, Alan Cox wrote:
> Ar Mer, 2006-09-13 am 14:41 +0000, ysgrifennodd Peter Lezoch:
> > Hi,
> > killing a server task that is operating on a UDP socket( AF_INET,
> > SOCK_DGRAM, IPPROTO_UDP ), leaves the socket in an unclosed state. 
> 
> For UDP the socket closes at the point the last user of the socket
> closes. For TCP there is a time delay mandated by the specification.
> 
> If you are seeing UDP sockets remain open when you kill a server make
> sure it hasn't forked other processes and passed them the file handle.

Additional note on REUSEADDR: The standard semantics of REUSEADDR on a
UDP socket is to allow several sockets to bind to the same address
simultaneously (!), i.e. if your server uses it you can start it several
times on the same socket, which is not what one normally wants.

Regards, Colin

