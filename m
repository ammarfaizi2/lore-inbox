Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264188AbTFHBfy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 21:35:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264190AbTFHBfy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 21:35:54 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73]:59337
	"EHLO michonline.com") by vger.kernel.org with ESMTP
	id S264188AbTFHBfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 21:35:50 -0400
Date: Sat, 7 Jun 2003 21:55:07 -0400
From: Ryan Anderson <ryan@michonline.com>
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
       "David S. Miller" <davem@redhat.com>,
       kernel-janitor-discuss@lists.sourceforge.net
Cc: netdev@oss.sgi.com
Subject: Re: [PATCH] Remove K&R prototypes in ppp_deflate.c
Message-ID: <20030608015507.GA19133@michonline.com>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>,
	"David S. Miller" <davem@redhat.com>,
	kernel-janitor-discuss@lists.sourceforge.net, netdev@oss.sgi.com
References: <20030608003916.GF20872@michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030608003916.GF20872@michonline.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I forgot to cc: netdev at first, sorry!

On Sat, Jun 07, 2003 at 08:39:16PM -0400, Ryan Anderson wrote:
> This patch removes the K&R initializers in ppp_deflate.c in favor of
> more modern constructions.
> 
> Once the other zlib cleanups appear to be stabilized, I'll look at
> moving those cleanups into ppp_deflate.c as well.
> 
> Dave, I think I sent this to you already once, if it's in your queue
> already, please ignore this resend.
> 
> # This is a BitKeeper generated patch for the following project:
> # Project Name: Linux kernel tree
> # This patch format is intended for GNU patch command version 2.5 or higher.
> # This patch includes the following deltas:
> #	           ChangeSet	1.1259  -> 1.1260 
> #	drivers/net/ppp_deflate.c	1.10    -> 1.11   
> #
> # The following is the BitKeeper ChangeSet Log
> # --------------------------------------------
> # 03/06/02	ryan@mythryan2.(none)	1.1260
> # Remove the use of K&R prototypes from ppp_deflate.c
> # --------------------------------------------
> #
> diff -Nru a/drivers/net/ppp_deflate.c b/drivers/net/ppp_deflate.c
> --- a/drivers/net/ppp_deflate.c	Mon Jun  2 09:39:01 2003
> +++ b/drivers/net/ppp_deflate.c	Mon Jun  2 09:39:01 2003
> @@ -78,8 +78,7 @@
>  static void	z_comp_stats __P((void *state, struct compstat *stats));
>  
>  static void
> -z_comp_free(arg)
> -    void *arg;
> +z_comp_free(void *arg)
>  {
>  	struct ppp_deflate_state *state = (struct ppp_deflate_state *) arg;
>  
> @@ -95,9 +94,7 @@
>   * Allocate space for a compressor.
>   */
>  static void *
> -z_comp_alloc(options, opt_len)
> -    unsigned char *options;
> -    int opt_len;
> +z_comp_alloc(unsigned char *options, int opt_len)
>  {
>  	struct ppp_deflate_state *state;
>  	int w_size;
> @@ -136,10 +133,8 @@
>  }
>  
>  static int
> -z_comp_init(arg, options, opt_len, unit, hdrlen, debug)
> -    void *arg;
> -    unsigned char *options;
> -    int opt_len, unit, hdrlen, debug;
> +z_comp_init(void *arg, unsigned char *options, 
> +		int opt_len, int unit, int hdrlen, int debug)
>  {
>  	struct ppp_deflate_state *state = (struct ppp_deflate_state *) arg;
>  
> @@ -161,8 +156,7 @@
>  }
>  
>  static void
> -z_comp_reset(arg)
> -    void *arg;
> +z_comp_reset(void *arg)
>  {
>  	struct ppp_deflate_state *state = (struct ppp_deflate_state *) arg;
>  
> @@ -171,11 +165,9 @@
>  }
>  
>  int
> -z_compress(arg, rptr, obuf, isize, osize)
> -    void *arg;
> -    unsigned char *rptr;	/* uncompressed packet (in) */
> -    unsigned char *obuf;	/* compressed packet (out) */
> -    int isize, osize;
> +z_compress(void *arg, unsigned char *rptr, /* uncompressed packet (in) */
> +		unsigned char *obuf,       /* compressed packet (out) */
> +		int isize, int osize)
>  {
>  	struct ppp_deflate_state *state = (struct ppp_deflate_state *) arg;
>  	int r, proto, off, olen, oavail;
> @@ -252,9 +244,7 @@
>  }
>  
>  static void
> -z_comp_stats(arg, stats)
> -    void *arg;
> -    struct compstat *stats;
> +z_comp_stats(void *arg, struct compstat *stats)
>  {
>  	struct ppp_deflate_state *state = (struct ppp_deflate_state *) arg;
>  
> @@ -262,8 +252,7 @@
>  }
>  
>  static void
> -z_decomp_free(arg)
> -    void *arg;
> +z_decomp_free(void *arg)
>  {
>  	struct ppp_deflate_state *state = (struct ppp_deflate_state *) arg;
>  
> @@ -279,9 +268,7 @@
>   * Allocate space for a decompressor.
>   */
>  static void *
> -z_decomp_alloc(options, opt_len)
> -    unsigned char *options;
> -    int opt_len;
> +z_decomp_alloc(unsigned char *options, int opt_len)
>  {
>  	struct ppp_deflate_state *state;
>  	int w_size;
> @@ -318,10 +305,8 @@
>  }
>  
>  static int
> -z_decomp_init(arg, options, opt_len, unit, hdrlen, mru, debug)
> -    void *arg;
> -    unsigned char *options;
> -    int opt_len, unit, hdrlen, mru, debug;
> +z_decomp_init(void *arg, unsigned char *options, 
> +		int opt_len, int unit, int hdrlen, int mru, int debug)
>  {
>  	struct ppp_deflate_state *state = (struct ppp_deflate_state *) arg;
>  
> @@ -344,8 +329,7 @@
>  }
>  
>  static void
> -z_decomp_reset(arg)
> -    void *arg;
> +z_decomp_reset(void *arg)
>  {
>  	struct ppp_deflate_state *state = (struct ppp_deflate_state *) arg;
>  
> @@ -370,12 +354,8 @@
>   * compression, even though they are detected by inspecting the input.
>   */
>  int
> -z_decompress(arg, ibuf, isize, obuf, osize)
> -    void *arg;
> -    unsigned char *ibuf;
> -    int isize;
> -    unsigned char *obuf;
> -    int osize;
> +z_decompress(void *arg, unsigned char *ibuf, int isize, 
> +			unsigned char *obuf, int osize)
>  {
>  	struct ppp_deflate_state *state = (struct ppp_deflate_state *) arg;
>  	int olen, seq, r;
> @@ -478,10 +458,7 @@
>   * Incompressible data has arrived - add it to the history.
>   */
>  static void
> -z_incomp(arg, ibuf, icnt)
> -    void *arg;
> -    unsigned char *ibuf;
> -    int icnt;
> +z_incomp(void *arg, unsigned char *ibuf, int icnt)
>  {
>  	struct ppp_deflate_state *state = (struct ppp_deflate_state *) arg;
>  	int proto, r;
> 
> 
> -- 
> 
> Ryan Anderson
>   sometimes Pug Majere
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 

Ryan Anderson
  sometimes Pug Majere
