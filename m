Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264284AbTLYKp3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 05:45:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264289AbTLYKp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 05:45:29 -0500
Received: from userbb201.dsl.pipex.com ([62.190.241.201]:57794 "EHLO
	irishsea.home.craig-wood.com") by vger.kernel.org with ESMTP
	id S264284AbTLYKp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 05:45:27 -0500
Date: Thu, 25 Dec 2003 10:45:26 +0000
From: Nick Craig-Wood <ncw1@axis.demon.co.uk>
To: Sven K <skoehler@upb.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: allow process or user to listen on priviledged ports?
Message-ID: <20031225104526.GA10239@axis.demon.co.uk>
References: <bscg1m$1eg$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bscg1m$1eg$1@sea.gmane.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 24, 2003 at 05:43:09PM +0100, Sven K?hler wrote:
> my problem is, that i want an application to listen on a priviledged 
> port (e.g. port 80) and to run as a "normal" unpriviledged user

I would give your application this capability (from #include "linux/capability.h")

  /* Allows binding to TCP/UDP sockets below 1024 */
  /* Allows binding to ATM VCIs below 32 */

  #define CAP_NET_BIND_SERVICE 10

You do this with a setuid wrapper which drops all capabilities but
that one and then runs your application.

One day there will be a way of doing this in the filing system, so
instead of doing a chmod u+s you do a chmod +CAP_NET_BIND_SERVICE or
something!  Until then use a setuid wrapper....

Here is a FAQ

  http://ftp.kernel.org/pub/linux/libs/security/linux-privs/kernel-2.4/capfaq-0.2.txt

Actually the FAQ mentions sucap which seems to be a fairly standard
program (its in Debian anyway!).  You could use this too...

-- 
Nick Craig-Wood
ncw1@axis.demon.co.uk
