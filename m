Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264748AbTBOJyf>; Sat, 15 Feb 2003 04:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264749AbTBOJyf>; Sat, 15 Feb 2003 04:54:35 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:39184 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264748AbTBOJye>; Sat, 15 Feb 2003 04:54:34 -0500
Date: Sat, 15 Feb 2003 10:04:24 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Bob Miller <rem@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>
Cc: Lars Magne Ingebrigtsen <larsi@gnus.org>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.60 5/9] Update the Archimedes parallel port driver for new module API.
Message-ID: <20030215100424.A20365@flint.arm.linux.org.uk>
Mail-Followup-To: Bob Miller <rem@osdl.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Lars Magne Ingebrigtsen <larsi@gnus.org>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
References: <20030214235325.GH13336@doc.pdx.osdl.net> <m3el6agzw0.fsf@quimbies.gnus.org> <20030215003700.GA13456@doc.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030215003700.GA13456@doc.pdx.osdl.net>; from rem@osdl.org on Fri, Feb 14, 2003 at 04:37:00PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2003 at 04:37:00PM -0800, Bob Miller wrote:
> -static void arc_inc_use_count(void)
> +static int arc_inc_use_count(void)
>  {
> -#ifdef MODULE
> -	MOD_INC_USE_COUNT;
> -#endif
> +	return try_module_get(THIS_MODULE);
>  }

Isn't one of the points of the module system that we don't try to run
code inside a module without the module being reference counted?

The normal way this is done is to add the module structure pointer into
a structure, and run try_module_get() from code external to the module
in question.  The above method would seem to violate that.

Rusty - comments?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

