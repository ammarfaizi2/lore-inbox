Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750915AbWCaXXH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750915AbWCaXXH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 18:23:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751001AbWCaXXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 18:23:07 -0500
Received: from sccrmhc11.comcast.net ([63.240.77.81]:20152 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1750915AbWCaXXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 18:23:05 -0500
Date: Fri, 31 Mar 2006 18:25:25 -0500
From: Latchesar Ionkov <lucho@ionkov.net>
To: Eric Van Hensbergen <ericvh@hera.kernel.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       v9fs-developer@lists.sourceforge.net, ericvh@gmail.com
Subject: Re: [V9fs-developer] [PATCH] 9p: cleanup unused functions
Message-ID: <20060331232525.GB7547@ionkov.net>
References: <200603312125.k2VLPnX0003602@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603312125.k2VLPnX0003602@hera.kernel.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm, the fact that they are not used currently doesn't mean that they are
not going to be used soon. Please don't remove them, I'll have to add them
back again :)

Thanks,
	Lucho

On Fri, Mar 31, 2006 at 09:25:49PM +0000, Eric Van Hensbergen said:
> >From nobody Mon Sep 17 00:00:00 2001
> From: Eric Van Hensbergen <ericvh@gmail.com>
> Date: Fri Mar 31 15:20:06 2006 -0600
> Subject: [PATCH] 9p: remove unused functions
> 
> This patch just removes some unused functions that were previously
> 
> Signed-off-by: Eric Van Hensbergen <ericvh@gmail.com>
> 
> ---
> 
>  fs/9p/conv.c  |   26 --------------------------
>  fs/9p/fcall.c |   25 -------------------------
>  fs/9p/mux.c   |   26 --------------------------
>  3 files changed, 0 insertions(+), 77 deletions(-)
> 
> 6b9742bbf5beb884dd9a1f285d04da8b14c6a09d
> diff --git a/fs/9p/conv.c b/fs/9p/conv.c
> index a767e05..63311ef 100644
> --- a/fs/9p/conv.c
> +++ b/fs/9p/conv.c
> @@ -535,32 +535,6 @@ struct v9fs_fcall *v9fs_create_tversion(
>  	return fc;
>  }
>  
> -#if 0
> -struct v9fs_fcall *v9fs_create_tauth(u32 afid, char *uname, char *aname)
> -{
> -	int size;
> -	struct v9fs_fcall *fc;
> -	struct cbuf buffer;
> -	struct cbuf *bufp = &buffer;
> -
> -	size = 4 + 2 + strlen(uname) + 2 + strlen(aname);	/* afid[4] uname[s] aname[s] */
> -	fc = v9fs_create_common(bufp, size, TAUTH);
> -	if (IS_ERR(fc))
> -		goto error;
> -
> -	v9fs_put_int32(bufp, afid, &fc->params.tauth.afid);
> -	v9fs_put_str(bufp, uname, &fc->params.tauth.uname);
> -	v9fs_put_str(bufp, aname, &fc->params.tauth.aname);
> -
> -	if (buf_check_overflow(bufp)) {
> -		kfree(fc);
> -		fc = ERR_PTR(-ENOMEM);
> -	}
> -      error:
> -	return fc;
> -}
> -#endif  /*  0  */
> -
>  struct v9fs_fcall *
>  v9fs_create_tattach(u32 fid, u32 afid, char *uname, char *aname)
>  {
> diff --git a/fs/9p/fcall.c b/fs/9p/fcall.c
> index 71742ba..d78cb77 100644
> --- a/fs/9p/fcall.c
> +++ b/fs/9p/fcall.c
> @@ -147,31 +147,6 @@ v9fs_t_clunk(struct v9fs_session_info *v
>  	return ret;
>  }
>  
> -#if 0
> -/**
> - * v9fs_v9fs_t_flush - flush a pending transaction
> - * @v9ses: 9P2000 session information
> - * @tag: tag to release
> - *
> - */
> -int v9fs_t_flush(struct v9fs_session_info *v9ses, u16 oldtag)
> -{
> -	int ret;
> -	struct v9fs_fcall *tc;
> -
> -	dprintk(DEBUG_9P, "oldtag %d\n", oldtag);
> -
> -	tc = v9fs_create_tflush(oldtag);
> -	if (!IS_ERR(tc)) {
> -		ret = v9fs_mux_rpc(v9ses->mux, tc, NULL);
> -		kfree(tc);
> -	} else
> -		ret = PTR_ERR(tc);
> -
> -	return ret;
> -}
> -#endif
> -
>  /**
>   * v9fs_t_stat - read a file's meta-data
>   * @v9ses: 9P2000 session information
> diff --git a/fs/9p/mux.c b/fs/9p/mux.c
> index 3e5b124..a06eb6f 100644
> --- a/fs/9p/mux.c
> +++ b/fs/9p/mux.c
> @@ -915,32 +915,6 @@ v9fs_mux_rpc(struct v9fs_mux_data *m, st
>  	return err;
>  }
>  
> -#if 0
> -/**
> - * v9fs_mux_rpcnb - sends 9P request without waiting for response.
> - * @m: mux data
> - * @tc: request to be sent
> - * @cb: callback function to be called when response arrives
> - * @cba: value to pass to the callback function
> - */
> -int v9fs_mux_rpcnb(struct v9fs_mux_data *m, struct v9fs_fcall *tc,
> -		   v9fs_mux_req_callback cb, void *a)
> -{
> -	int err;
> -	struct v9fs_req *req;
> -
> -	req = v9fs_send_request(m, tc, cb, a);
> -	if (IS_ERR(req)) {
> -		err = PTR_ERR(req);
> -		dprintk(DEBUG_MUX, "error %d\n", err);
> -		return PTR_ERR(req);
> -	}
> -
> -	dprintk(DEBUG_MUX, "mux %p tc %p tag %d\n", m, tc, req->tag);
> -	return 0;
> -}
> -#endif  /*  0  */
> -
>  /**
>   * v9fs_mux_cancel - cancel all pending requests with error
>   * @m: mux data
> -- 
> 1.2.4.gb0a3de4
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by xPML, a groundbreaking scripting language
> that extends applications into web and mobile media. Attend the live webcast
> and join the prime developer group breaking into this new coding territory!
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
> _______________________________________________
> V9fs-developer mailing list
> V9fs-developer@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/v9fs-developer
