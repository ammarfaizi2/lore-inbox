Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261432AbVAXDol@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261432AbVAXDol (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 22:44:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261433AbVAXDol
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 22:44:41 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:427 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261432AbVAXDog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 22:44:36 -0500
Subject: Re: [patch 1/13] Qsort
From: Charles R Harris <charris208@comcast.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Sun, 23 Jan 2005 20:44:33 -0700
Message-Id: <1106538274.32342.13.camel@tethys>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are semi-templated versions of quicksort and heapsort, just for
completeness. The quicksort uses the median of three.

Chuck

void  quicksort0<typename>(<typename> *pl, <typename> *pr)
{
	<typename> vp, SWAP_temp;
	<typename> *stack[100], **sptr = stack, *pm, *pi, *pj, *pt;
        
	for(;;) {
		while ((pr - pl) > 15) {
			/* quicksort partition */
			pm = pl + ((pr - pl) >> 1);
			if (<lessthan>(*pm,*pl)) SWAP(*pm,*pl);
			if (<lessthan>(*pr,*pm)) SWAP(*pr,*pm);
			if (<lessthan>(*pm,*pl)) SWAP(*pm,*pl);
			vp = *pm;
			pi = pl;
			pj = pr - 1;
			SWAP(*pm,*pj);
			for(;;) {
				do ++pi; while (<lessthan>(*pi,vp));
				do --pj; while (<lessthan>(vp,*pj));
				if (pi >= pj)  break;
				SWAP(*pi,*pj);
			}
			SWAP(*pi,*(pr-1));
			/* push largest partition on stack */
			if (pi - pl < pr - pi) {
				*sptr++ = pi + 1;
				*sptr++ = pr;
				pr = pi - 1;
			}else{
				*sptr++ = pl;
				*sptr++ = pi - 1;
				pl = pi + 1;
			}
		}
		/* insertion sort */
		for(pi = pl + 1; pi <= pr; ++pi) {
			vp = *pi;
			for(pj = pi, pt = pi - 1; pj > pl && <lessthan>(vp, *pt);) {
				*pj-- = *pt--;
			}
			*pj = vp;
		}
		if (sptr == stack) break;
		pr = *(--sptr);
		pl = *(--sptr);
	}
}

void heapsort0<typename>(<typename> *a, long n)
{
	<typename> tmp;
	long i,j,l;

	/* The array needs to be offset by one for heapsort indexing */
        a -= 1;
        
	for (l = n>>1; l > 0; --l) {
		tmp = a[l];
		for (i = l, j = l<<1; j <= n;) {
			if (j < n && <lessthan>(a[j], a[j+1])) 
				j += 1;
			if (<lessthan>(tmp, a[j])) {
				a[i] = a[j];
				i = j;
				j += j;
			}else
				break;
		}
		a[i] = tmp;
	} 

	for (; n > 1;) {
		tmp = a[n];
		a[n] = a[1];
		n -= 1;
		for (i = 1, j = 2; j <= n;) {
			if (j < n && <lessthan>(a[j], a[j+1]))
				j++;
			if (<lessthan>(tmp, a[j])) {
				a[i] = a[j];
				i = j;
				j += j;
			}else
				break;
		}
		a[i] = tmp;
	}
}



