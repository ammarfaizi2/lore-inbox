Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261660AbUL3QDZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261660AbUL3QDZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 11:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261663AbUL3QDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 11:03:25 -0500
Received: from web51507.mail.yahoo.com ([206.190.38.199]:16740 "HELO
	web51507.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261660AbUL3QDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 11:03:17 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=PduFDW/ZySg2knzWu8fUQBoobpeS0In61OTD7zpbrVJBr+LRHl+4pnuYCRBdpgs5ne9JezHBhdRisKR0Fm0RzpPryGUpflAj4JAMZPMDUWoEa547uDVL1U84EX1dsk/SVBQUYp6bkn4jA4H30cDaLE6bzHALj/dyta1y3P+ay3Q=  ;
Message-ID: <20041230160317.94337.qmail@web51507.mail.yahoo.com>
Date: Thu, 30 Dec 2004 08:03:17 -0800 (PST)
From: Park Lee <parklee_sel@yahoo.com>
Subject: Issue on packets sending through ip_route_output_key() to xfrm_lookup() in native IPsec
To: linux-kernel@vger.kernel.org
Cc: linux-net@vger.kernel.org, dave@thedillows.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  In Linux native IPsec, there is a function
xfrm_lookup(struct dst_entry **dst_p, struct flowi
*fl, struct sock *sk, int flags) (in
/usr/src/linux-2.6.5-1.358/net/xfrm/xfrm_policy.c).
Whenever a packet is sending, kernel will call
xfrm_lookup() to finds/creates a bundle for it. 
  xfrm_lookup() can be called by many functions. one
of these functions is ip_route_output_key(). 
we can see its definition as follows:

int ip_route_output_key(struct rtable **rp, struct
flowi *flp)
{
        int err;
        if ((err = __ip_route_output_key(rp, flp)) !=
0)
                return err;
        return flp->proto ? xfrm_lookup((struct
dst_entry**)rp, flp, NULL, 0) : 0;
}

As ip_route_output_key() calls xfrm_lookup() with the
argument sk set to NULL, Does this means that the
packets sending through ip_route_output_key() to
xfrm_lookup() have no corresponding local socket with
them (because their sk is NULL)? Are these packets all
created by special kernel socket (i.e. icmp_socket and
tcp_socket)? 

Thank you very much.


=====
Best Regards,
Park Lee


		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - Helps protect you from nasty viruses. 
http://promotions.yahoo.com/new_mail
