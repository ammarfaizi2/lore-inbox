Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130762AbRADJ2a>; Thu, 4 Jan 2001 04:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131257AbRADJ2U>; Thu, 4 Jan 2001 04:28:20 -0500
Received: from pc63-gui14.cable.ntl.com ([213.105.184.63]:40200 "EHLO
	cyberelk.elk.co.uk") by vger.kernel.org with ESMTP
	id <S130762AbRADJ2K>; Thu, 4 Jan 2001 04:28:10 -0500
Date: Thu, 4 Jan 2001 09:27:51 +0000
From: Tim Waugh <tim@cyberelk.demon.co.uk>
To: Peter Osterlund <peter.osterlund@mailbox.swipnet.se>
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
        linux-parport@torque.net
Subject: Re: Printing to off-line printer in 2.4.0-prerelease
Message-ID: <20010104092751.A4416@cyberelk.demon.co.uk>
In-Reply-To: <m2k88czda4.fsf@ppro.localdomain> <20010103201344.A3203@athlon.random> <m2hf3gz6yc.fsf@ppro.localdomain> <20010103223504.L32185@athlon.random> <m266jww55q.fsf@ppro.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m266jww55q.fsf@ppro.localdomain>; from peter.osterlund@mailbox.swipnet.se on Thu, Jan 04, 2001 at 01:08:01AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 04, 2001 at 01:08:01AM +0100, Peter Osterlund wrote:

> The tunelp man-page seems to think there are printers that need the
> LP_CAREFUL handling. I also noted that if I disconnect my printer from
> the computer, the data will no longer be lost. Apparently the printer
> confuses the parallel port when it is powered off.

I'm afraid that with some (most) printers there's just nothing that
can be done about this, to my knowledge.

> @@ -188,10 +188,7 @@
>  	int error = 0;
>  	unsigned int last = lp_table[minor].last_error;
>  	unsigned char status = r_str(minor);
> -	if ((status & LP_PERRORP) && !(LP_F(minor) & LP_CAREFUL))
> -		/* No error. */
> -		last = 0;
> -	else if ((status & LP_POUTPA)) {
> +	if ((status & LP_POUTPA)) {
>  		if (last != LP_POUTPA) {
>  			last = LP_POUTPA;
>  			printk(KERN_INFO "lp%d out of paper\n", minor);

Believe it or not, there are some printers out there that wave
LP_POUTPA all over the place even when they're happy: they set
LP_PERRORP to mean 'happy', which is what the check is for.

So this part of the patch would break that. :-(

Tim.
*/

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6VEIXONXnILZ4yVIRAjO7AKChug3lPUy3hDkf5jkKSfrndBlf9ACgh0JG
L/WPcTTe4ZgVFOkC+1QbRTg=
=z2rp
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
