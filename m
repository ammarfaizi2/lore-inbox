Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314885AbSENBEY>; Mon, 13 May 2002 21:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314889AbSENBEX>; Mon, 13 May 2002 21:04:23 -0400
Received: from web10402.mail.yahoo.com ([216.136.130.94]:44369 "HELO
	web10402.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S314885AbSENBEW>; Mon, 13 May 2002 21:04:22 -0400
Message-ID: <20020514010422.58937.qmail@web10402.mail.yahoo.com>
Date: Tue, 14 May 2002 11:04:22 +1000 (EST)
From: =?iso-8859-1?q?Steve=20Kieu?= <haiquy@yahoo.com>
Subject: Re: OOPS 2.4.19-pre7-ac4 (Was: strange things in kernel 2.4.19-pre7-ac4 + preempt patch)
To: kernel <linux-kernel@vger.kernel.org>
Cc: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
In-Reply-To: <Pine.LNX.4.44.0205131830080.353-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1470913760-1021338262=:58008"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-1470913760-1021338262=:58008
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

 --- Zwane Mwaikambo <zwane@linux.realnet.co.sz>
wrote: > Could you try this patch, Bill came across it
in
> rmap testing.
> 
> Regards,
> 	Zwane
> 
> ---
> linux-2.4.19-pre-ac/drivers/char/drm/i810_dma.c.orig
> Mon May 13 18:27:40 2002
> +++ linux-2.4.19-pre-ac/drivers/char/drm/i810_dma.c
> Mon May 13 18:28:37 2002
> @@ -293,8 +293,8 @@
>  {
>  	if (page) {
>  		struct page *p = virt_to_page(page);
> -		put_page(p);
>  		UnlockPage(p);
> +		put_page(p);
>  		free_page(page);
>  	}
>  }
> ---
>
linux-2.4.19-pre-ac/drivers/char/drm-4.0/i810_dma.c.orig
> Mon May 13 18:37:37 2002
> +++
> linux-2.4.19-pre-ac/drivers/char/drm-4.0/i810_dma.c
> Mon May 13 18:38:03 2002
> @@ -291,9 +291,9 @@
>  	struct page * p = virt_to_page(page);
>  	if(page == 0UL) 
>  		return;
> -	
> +
> +	UnlockPage(p);	
>  	put_page(p);
> -	UnlockPage(p);
>  	free_page(page);
>  	return;
>  }
> 
> -- 

It doesn't work, I attached the oop log here...



=====
Steve Kieu

http://briefcase.yahoo.com.au - Yahoo! Briefcase
- Save your important files online for easy access!
--0-1470913760-1021338262=:58008
Content-Type: application/octet-stream; name="oop.log"
Content-Transfer-Encoding: base64
Content-Description: oop.log
Content-Disposition: attachment; filename="oop.log"

a3N5bW9vcHMgMi40LjQgb24gaTY4NiAyLjQuMTktcHJlNy1hYzQuICBPcHRp
b25zIHVzZWQKICAgICAtViAoZGVmYXVsdCkKICAgICAtayAvcHJvYy9rc3lt
cyAoZGVmYXVsdCkKICAgICAtbCAvcHJvYy9tb2R1bGVzIChkZWZhdWx0KQog
ICAgIC1vIC9saWIvbW9kdWxlcy8yLjQuMTktcHJlNy1hYzQvIChkZWZhdWx0
KQogICAgIC1tIC9ib290L1N5c3RlbS5tYXAgKGRlZmF1bHQpCgpXYXJuaW5n
OiBZb3UgZGlkIG5vdCB0ZWxsIG1lIHdoZXJlIHRvIGZpbmQgc3ltYm9sIGlu
Zm9ybWF0aW9uLiAgSSB3aWxsCmFzc3VtZSB0aGF0IHRoZSBsb2cgbWF0Y2hl
cyB0aGUga2VybmVsIGFuZCBtb2R1bGVzIHRoYXQgYXJlIHJ1bm5pbmcKcmln
aHQgbm93IGFuZCBJJ2xsIHVzZSB0aGUgZGVmYXVsdCBvcHRpb25zIGFib3Zl
IGZvciBzeW1ib2wgcmVzb2x1dGlvbi4KSWYgdGhlIGN1cnJlbnQga2VybmVs
IGFuZC9vciBtb2R1bGVzIGRvIG5vdCBtYXRjaCB0aGUgbG9nLCB5b3UgY2Fu
IGdldAptb3JlIGFjY3VyYXRlIG91dHB1dCBieSB0ZWxsaW5nIG1lIHRoZSBr
ZXJuZWwgdmVyc2lvbiBhbmQgd2hlcmUgdG8gZmluZAptYXAsIG1vZHVsZXMs
IGtzeW1zIGV0Yy4gIGtzeW1vb3BzIC1oIGV4cGxhaW5zIHRoZSBvcHRpb25z
LgoKY3B1OiAwLCBjbG9ja3M6IDY2ODIwOSwgc2xpY2U6IDMzNDEwNAprZXJu
ZWwgQlVHIGF0IGZpbGVtYXAuYzo4NTEhCmludmFsaWQgb3BlcmFuZDogMDAw
MApDUFU6ICAgIDAKRUlQOiAgICAwMDEwOls8YzAxMmI0OTc+XSAgICBOb3Qg
dGFpbnRlZApVc2luZyBkZWZhdWx0cyBmcm9tIGtzeW1vb3BzIC10IGVsZjMy
LWkzODYgLWEgaTM4NgpFRkxBR1M6IDAwMDEzMjQ2CmVheDogYzEwMDAwMGMg
ICBlYng6IGMwMjI3NjQwICAgZWN4OiAwMDAwMDAxYyAgIGVkeDogMDAwMDAw
MDAKZXNpOiBjMTE5Y2NkYyAgIGVkaTogYzAyNzkyYzAgICBlYnA6IGM2NmRm
ZWQ4ICAgZXNwOiBjNjZkZmVkMApkczogMDAxOCAgIGVzOiAwMDE4ICAgc3M6
IDAwMTgKUHJvY2VzcyBYIChwaWQ6IDEwMCwgc3RhY2twYWdlPWM2NmRmMDAw
KQpTdGFjazogYzU0OWMwMDAgYzExMTJmYmMgYzY2ZGZlZWMgYzAxOGU0YTkg
YzExMTJmYmMgYzdkMTI3Y2MgYzdkMTM4MDAgYzY2ZGZmMDggCiAgICAgICBj
MDE4ZTUxMSBjMDI3OTJjMCBjNTQ5YzAwMCAwMDAwMDAwMCBiZmZmZjk2OCBj
MDI3OTJjMCBjNjZkZmY2OCBjMDE4ZTllOSAKICAgICAgIGMwMjc5MmMwIDAw
MDAwMDAwIGMwMjc5MmMwIDAwMDAwMDAyIDAwMDAwMDAwIDAwMDAwMDAwIDAw
MDAwMDAwIDAwMDAwMDAwIApDYWxsIFRyYWNlOiBbPGMwMThlNGE5Pl0gWzxj
MDE4ZTUxMT5dIFs8YzAxOGU5ZTk+XSBbPGMwMThkZjA0Pl0gWzxjMDE0OWVk
Yj5dIAogICBbPGMwMTA4YzViPl0gCkNvZGU6IDBmIDBiIDUzIDAzIDQ4IDVj
IDIwIGMwIDhkIDQ2IDA0IDM5IDQ2IDA0IDc0IDExIDViIDg5IGYwIDMxIAoK
Pj5FSVA7IGMwMTJiNDk3IDx1bmxvY2tfcGFnZSs0Ny83MD4gICA8PT09PT0K
VHJhY2U7IGMwMThlNGE5IDxpODEwX2ZyZWVfcGFnZSsyOS81MD4KVHJhY2U7
IGMwMThlNTExIDxpODEwX2RtYV9jbGVhbnVwKzQxL2IwPgpUcmFjZTsgYzAx
OGU5ZTkgPGk4MTBfZG1hX2luaXQrYjkvZTA+ClRyYWNlOyBjMDE4ZGYwNCA8
aTgxMF9pb2N0bCtlNC8xMDA+ClRyYWNlOyBjMDE0OWVkYiA8c3lzX2lvY3Rs
KzI2Yi8yYjA+ClRyYWNlOyBjMDEwOGM1YiA8c3lzdGVtX2NhbGwrMzMvMzg+
CkNvZGU7ICBjMDEyYjQ5NyA8dW5sb2NrX3BhZ2UrNDcvNzA+CjAwMDAwMDAw
IDxfRUlQPjoKQ29kZTsgIGMwMTJiNDk3IDx1bmxvY2tfcGFnZSs0Ny83MD4g
ICA8PT09PT0KICAgMDogICAwZiAwYiAgICAgICAgICAgICAgICAgICAgIHVk
MmEgICAgICA8PT09PT0KQ29kZTsgIGMwMTJiNDk5IDx1bmxvY2tfcGFnZSs0
OS83MD4KICAgMjogICA1MyAgICAgICAgICAgICAgICAgICAgICAgIHB1c2gg
ICAlZWJ4CkNvZGU7ICBjMDEyYjQ5YSA8dW5sb2NrX3BhZ2UrNGEvNzA+CiAg
IDM6ICAgMDMgNDggNWMgICAgICAgICAgICAgICAgICBhZGQgICAgMHg1Yygl
ZWF4KSwlZWN4CkNvZGU7ICBjMDEyYjQ5ZCA8dW5sb2NrX3BhZ2UrNGQvNzA+
CiAgIDY6ICAgMjAgYzAgICAgICAgICAgICAgICAgICAgICBhbmQgICAgJWFs
LCVhbApDb2RlOyAgYzAxMmI0OWYgPHVubG9ja19wYWdlKzRmLzcwPgogICA4
OiAgIDhkIDQ2IDA0ICAgICAgICAgICAgICAgICAgbGVhICAgIDB4NCglZXNp
KSwlZWF4CkNvZGU7ICBjMDEyYjRhMiA8dW5sb2NrX3BhZ2UrNTIvNzA+CiAg
IGI6ICAgMzkgNDYgMDQgICAgICAgICAgICAgICAgICBjbXAgICAgJWVheCww
eDQoJWVzaSkKQ29kZTsgIGMwMTJiNGE1IDx1bmxvY2tfcGFnZSs1NS83MD4K
ICAgZTogICA3NCAxMSAgICAgICAgICAgICAgICAgICAgIGplICAgICAyMSA8
X0VJUCsweDIxPiBjMDEyYjRiOCA8dW5sb2NrX3BhZ2UrNjgvNzA+CkNvZGU7
ICBjMDEyYjRhNyA8dW5sb2NrX3BhZ2UrNTcvNzA+CiAgMTA6ICAgNWIgICAg
ICAgICAgICAgICAgICAgICAgICBwb3AgICAgJWVieApDb2RlOyAgYzAxMmI0
YTggPHVubG9ja19wYWdlKzU4LzcwPgogIDExOiAgIDg5IGYwICAgICAgICAg
ICAgICAgICAgICAgbW92ICAgICVlc2ksJWVheApDb2RlOyAgYzAxMmI0YWEg
PHVubG9ja19wYWdlKzVhLzcwPgogIDEzOiAgIDMxIDAwICAgICAgICAgICAg
ICAgICAgICAgeG9yICAgICVlYXgsKCVlYXgpCgoKMSB3YXJuaW5nIGlzc3Vl
ZC4gIFJlc3VsdHMgbWF5IG5vdCBiZSByZWxpYWJsZS4K

--0-1470913760-1021338262=:58008--
