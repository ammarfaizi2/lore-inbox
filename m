Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261874AbTBJRpe>; Mon, 10 Feb 2003 12:45:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261900AbTBJRpd>; Mon, 10 Feb 2003 12:45:33 -0500
Received: from beta.bandnet.com.br ([200.195.133.131]:51979 "EHLO
	beta.bandnet.com.br") by vger.kernel.org with ESMTP
	id <S261874AbTBJRpc>; Mon, 10 Feb 2003 12:45:32 -0500
From: "User &" <breno_silva@beta.bandnet.com.br>
To: linux-kernel@vger.kernel.org
Subject: New demand page function
Date: Mon, 10 Feb 2003 14:57:44 -0300
Message-Id: <20030210175744.M61715@beta.bandnet.com.br>
X-Mailer: Open WebMail 1.81 20021127
X-OriginatingIP: 200.167.224.227 (breno_silva)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi , i done one function for demand page.
This do almost the same thing of the others functions , the diffence is in 
when do the page allocations.
This still need some tests , but i´d like to know your opinions.

struct page *f_a_page(unsigned int gfp_mask,zone_t *zone,pte_t pte)
{
 struct page *page;
 struct page *new;
 char *kaddr;
 int i,j;
 
 /* Teste if there are many pages to alloc and try to alloc just one page*/

reload: if((zone->free_pages >= zone->pages_min)) {
 	page = alloc_page(gfp_mask,0);
 		if(!page)
 			return NOPAGE_OOM;
 /*Map alloced page*/
	
	kaddr = (char *)kmap(page);
		if(!kaddr)
			return;

	return page;
	}
 /*If there aren´t no much pages , try to free some pages*/

     else {
	i = 0;
        do {
        	i++;
	 	j = 2*2*i;
		}while((j > zone->pages_min));
 
		new = pte_page(pte);
		if(new) {
			if(new->count !=0)
				spin_lock(&zone->lock);
				 __free_pages(new,i);
				spin_unlock(&zone->lock);
				goto reload;
			}
}
	   
thanks
Breno
----------------------
WebMail Bandnet.com.br

