Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751697AbVKJDbo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751697AbVKJDbo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 22:31:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751692AbVKJDbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 22:31:44 -0500
Received: from xproxy.gmail.com ([66.249.82.204]:47309 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751164AbVKJDbo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 22:31:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VEdFt0kJEAO+D4y2eZQQoEAaFcLy5S5Mf0Uwfd8recoy2GKrYdjLISSSC4fBYcupxZTg35KEsgdTAtdQWs2Nypop8BWZMYzTMheBwKaWibX93kLnJcbLnZS8sRFKDJhOKrwsJQqhdPWI3PhuE7qlSM2KF4LegjJB8EMauW4YKfg=
Message-ID: <1e62d1370511091931h7128a4bblf58773c456ee1517@mail.gmail.com>
Date: Thu, 10 Nov 2005 08:31:41 +0500
From: Fawad Lateef <fawadlateef@gmail.com>
To: John Smith <multisyncfe991@hotmail.com>
Subject: Re: Does Printk() block another CPU in dual cpu platforms?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <BAY108-DAV96479E4CE0434E15A5ABE93670@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <BAY108-DAV14071EF16A4482FB4B691593D10@phx.gbl>
	 <20050714051653.GP8907@alpha.home.local>
	 <BAY108-DAV7F3CC1BA8D84C5323469193D10@phx.gbl>
	 <1121358399.4685.9.camel@localhost>
	 <BAY108-DAV96479E4CE0434E15A5ABE93670@phx.gbl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/05, John Smith <multisyncfe991@hotmail.com> wrote:
>
> I just have a question about the usage of printk in multi-processor
> platforms. If the program on two CPUs both try to call printk to output
> something, will the program running on one CPUs get blocked (or just
> spinning there) till the other is done with printk()?
>

I think yes, but for a very less time as printk holds the spin_lock to
logbuf_lock which will make to wait the printk on other CPU, and then
printk just copies the content to log_buffer and then call
release_console_sem which actually send the data to console later !

--
Fawad Lateef
