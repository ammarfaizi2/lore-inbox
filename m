Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263009AbTCWK1y>; Sun, 23 Mar 2003 05:27:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263010AbTCWK1y>; Sun, 23 Mar 2003 05:27:54 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:2067 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263009AbTCWK1w>; Sun, 23 Mar 2003 05:27:52 -0500
Date: Sun, 23 Mar 2003 10:38:54 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: "Lists (lst)" <linux@lapd.cj.edu.ro>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4+ptrace exploit fix breaks root's ability to strace
Message-ID: <20030323103854.A16548@flint.arm.linux.org.uk>
Mail-Followup-To: "Lists (lst)" <linux@lapd.cj.edu.ro>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030322103121.A16994@flint.arm.linux.org.uk> <1048345130.8912.9.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.51L0.0303231225070.15290@lapd.cj.edu.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.51L0.0303231225070.15290@lapd.cj.edu.ro>; from linux@lapd.cj.edu.ro on Sun, Mar 23, 2003 at 12:31:39PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vurnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 23, 2003 at 12:31:39PM +0200, Lists (lst) wrote:
> The patch breaks /proc/<pid>/cmdline and /proc/<pid>/environ for 'non 
> dumpable' processes, even for root.

This fix is definitely wrong.

> -	if (!is_dumpable(tsk) || (&init_mm == mm))
> +	if ((!is_dumpable(tsk) || (&init_mm == mm)) && (current->uid != 0))
>  		mm = NULL;

Today, security is based around the capability system, not UID numbers.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

