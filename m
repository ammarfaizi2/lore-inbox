Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265800AbTAPJKw>; Thu, 16 Jan 2003 04:10:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265939AbTAPJKw>; Thu, 16 Jan 2003 04:10:52 -0500
Received: from outdoor.Deuromedia.ro ([194.176.161.44]:46094 "EHLO
	outdoor.deuromedia.ro") by vger.kernel.org with ESMTP
	id <S265800AbTAPJKv>; Thu, 16 Jan 2003 04:10:51 -0500
Content-Type: text/plain; charset=US-ASCII
From: Dorin Lazar <lazar@deuromedia.ro>
To: DervishD <raul@pleyades.net>
Subject: Re: Changing argv[0] under Linux.
Date: Thu, 16 Jan 2003 11:19:35 +0200
User-Agent: KMail/1.4.1
References: <20030114220401.GB241@DervishD> <jeel7ehzon.fsf@sykes.suse.de> <20030115220317.GL47@DervishD>
In-Reply-To: <20030115220317.GL47@DervishD>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301161119.35868.lazar@deuromedia.ro>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 16 January 2003 00:03, DervishD wrote:
>     Yes, I suppose that exec'ing whatever is in argv0 is not a good
> idea :((( Didn't think about it.
>     Any suggestion on how to get the binary name from the core image?
    Does it have to be an exec? 
    Perhaps something like this:
int main(int argc, char **argv)
{
	if (fork ()) {
		strcpy (argv[0], "Fake name 00001");
		setpgrp (); /* very important when dealing with stuff like this */
		pause(); /* code for personality "Fake name 00001" */
		return 0;
	}
	strcpy (argv[0], "Fake name 00002");
	setpgrp ();
	pause(); /* code for personality "Fake name 00002" */

}
    this thing works - at least on my box...
    But, of course, I could be mistaken, and I miss to see some other 
important details. Good luck.
    Dorin.
-- 
Dorin "sp00ky" Lazar, programmer
Registered Linux user #162515

