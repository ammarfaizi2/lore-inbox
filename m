Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750787AbWINP2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbWINP2z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 11:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750793AbWINP2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 11:28:55 -0400
Received: from ns.firmix.at ([62.141.48.66]:43446 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S1750784AbWINP2x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 11:28:53 -0400
Subject: Re: support for limit of open file descriptors for a child process
From: Bernd Petrovitsch <bernd@firmix.at>
To: Ram Gupta <ram.gupta5@gmail.com>
Cc: linux mailing-list <linux-kernel@vger.kernel.org>
In-Reply-To: <728201270609140821l7cf30578y2f45479b03e77f64@mail.gmail.com>
References: <728201270609140821l7cf30578y2f45479b03e77f64@mail.gmail.com>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Thu, 14 Sep 2006 17:28:48 +0200
Message-Id: <1158247728.24835.20.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.389 () AWL,BAYES_00,FORGED_RCVD_HELO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-09-14 at 10:21 -0500, Ram Gupta wrote:
> Hi,
>     I came across a problem regarding the issue of number of open
> file descriptors.The scenario is as below.
>  I have a controlling process which launches other different
> apllication including third party ones. It also enforces various
> resource limits including number of open file descriptors. This
> process forks & reads the resource limits from a configuration files,
> applies the resource limits & then execs for the corresponding
> application. The process has its own various number of open file
> descriptors. If the limit of open file descriptor for the child
> application is less than the number of file descriptors  of the parent
> process, then the child application file can not be opened & exec
> fails in this case.
> 
> I searched solution for this problem but could not find an existing
> way to solve it. I thought of couple of ways to do it. One idea is to

-) simply close(2) the superfluous file descriptors unconditionally
   before exec(2)ing the child process 
-) set the close-on-exec flag via fcntl(2) on these file descriptors
   after opening them

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

