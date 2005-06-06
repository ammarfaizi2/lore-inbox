Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261670AbVFFUcK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbVFFUcK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 16:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261668AbVFFUDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 16:03:31 -0400
Received: from agmk.net ([217.73.17.121]:270 "EHLO mail.agmk.net")
	by vger.kernel.org with ESMTP id S261654AbVFFT6a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 15:58:30 -0400
From: Pawel Sikora <pluto@agmk.net>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Subject: Re: [2.6.11.11] oops in scheduler_tick
Date: Mon, 6 Jun 2005 21:58:10 +0200
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <200506060805.38799.pluto@agmk.net> <Pine.LNX.4.58.0506061436520.17981@artax.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.58.0506061436520.17981@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506062158.11514.pluto@agmk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 of June 2005 14:40, Mikulas Patocka wrote:
> Hi
>
> Pls disassemble the function do_wait, that was interrupted
> (with objdump -d exit.o) and post it.
>
> Mikulas
>

00001b27 <do_wait>:
    1b27:	55                   	push   %ebp
    1b28:	89 e5                	mov    %esp,%ebp
    1b2a:	57                   	push   %edi
    1b2b:	56                   	push   %esi
    1b2c:	53                   	push   %ebx
    1b2d:	83 ec 1c             	sub    $0x1c,%esp
    1b30:	8b 75 10             	mov    0x10(%ebp),%esi
    1b33:	8d 7d e0             	lea    0xffffffe0(%ebp),%edi
    1b36:	fc                   	cld    
    1b37:	31 c0                	xor    %eax,%eax
    1b39:	ab                   	stos   %eax,%es:(%edi)
    1b3a:	ab                   	stos   %eax,%es:(%edi)
    1b3b:	ab                   	stos   %eax,%es:(%edi)
    1b3c:	ab                   	stos   %eax,%es:(%edi)
    1b3d:	ab                   	stos   %eax,%es:(%edi)
    1b3e:	b8 00 e0 ff ff       	mov    $0xffffe000,%eax
    1b43:	21 e0                	and    %esp,%eax
    1b45:	8b 10                	mov    (%eax),%edx
    1b47:	89 55 e4             	mov    %edx,0xffffffe4(%ebp)
    1b4a:	c7 45 e8 00 00 00 00 	movl   $0x0,0xffffffe8(%ebp)
    1b51:	8b 00                	mov    (%eax),%eax
    1b53:	8b 80 5c 04 00 00    	mov    0x45c(%eax),%eax
    1b59:	83 c0 08             	add    $0x8,%eax
    1b5c:	8d 55 e0             	lea    0xffffffe0(%ebp),%edx
    1b5f:	e8 fc ff ff ff       	call   1b60 <do_wait+0x39>
    1b64:	b8 00 e0 ff ff       	mov    $0xffffe000,%eax
    1b69:	21 e0                	and    %esp,%eax
    1b6b:	8b 10                	mov    (%eax),%edx
    1b6d:	c7 02 01 00 00 00    	movl   $0x1,(%edx)
    1b73:	8b 18                	mov    (%eax),%ebx
    1b75:	c7 45 d8 00 00 00 00 	movl   $0x0,0xffffffd8(%ebp)
    1b7c:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
    1b82:	e9 1f 01 00 00       	jmp    1ca6 <do_wait+0x17f>
    1b87:	8b 7d dc             	mov    0xffffffdc(%ebp),%edi
    1b8a:	81 ef a8 00 00 00    	sub    $0xa8,%edi
    1b90:	57                   	push   %edi
    1b91:	ff 75 0c             	pushl  0xc(%ebp)
    1b94:	ff 75 08             	pushl  0x8(%ebp)
    1b97:	e8 5f f6 ff ff       	call   11fb <eligible_child>
    1b9c:	89 c2                	mov    %eax,%edx
    1b9e:	83 c4 0c             	add    $0xc,%esp
    1ba1:	85 c0                	test   %eax,%eax
    1ba3:	0f 84 f8 00 00 00    	je     1ca1 <do_wait+0x17a>
    1ba9:	8b 4d dc             	mov    0xffffffdc(%ebp),%ecx
    1bac:	8b 81 58 ff ff ff    	mov    0xffffff58(%ecx),%eax
    1bb2:	83 f8 04             	cmp    $0x4,%eax
    1bb5:	74 27                	je     1bde <do_wait+0xb7>
    1bb7:	83 f8 08             	cmp    $0x8,%eax
    1bba:	75 79                	jne    1c35 <do_wait+0x10e>
    1bbc:	8b 47 10             	mov    0x10(%edi),%eax
    1bbf:	a8 01                	test   $0x1,%al
    1bc1:	0f 84 da 00 00 00    	je     1ca1 <do_wait+0x17a>
    1bc7:	f6 c4 04             	test   $0x4,%ah
    1bca:	74 12                	je     1bde <do_wait+0xb7>
    1bcc:	8b 87 98 00 00 00    	mov    0x98(%edi),%eax
    1bd2:	39 87 9c 00 00 00    	cmp    %eax,0x9c(%edi)
    1bd8:	0f 84 c3 00 00 00    	je     1ca1 <do_wait+0x17a>
    1bde:	f6 45 0c 02          	testb  $0x2,0xc(%ebp)
    1be2:	75 22                	jne    1c06 <do_wait+0xdf>
    1be4:	8b 47 10             	mov    0x10(%edi),%eax
    1be7:	a8 01                	test   $0x1,%al
    1be9:	0f 84 ab 00 00 00    	je     1c9a <do_wait+0x173>
    1bef:	f6 c4 04             	test   $0x4,%ah
    1bf2:	74 12                	je     1c06 <do_wait+0xdf>
    1bf4:	8b 87 98 00 00 00    	mov    0x98(%edi),%eax
    1bfa:	39 87 9c 00 00 00    	cmp    %eax,0x9c(%edi)
    1c00:	0f 84 94 00 00 00    	je     1c9a <do_wait+0x173>
    1c06:	ff 75 18             	pushl  0x18(%ebp)
    1c09:	ff 75 14             	pushl  0x14(%ebp)
    1c0c:	56                   	push   %esi
    1c0d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1c10:	25 00 00 00 01       	and    $0x1000000,%eax
    1c15:	50                   	push   %eax
    1c16:	31 c0                	xor    %eax,%eax
    1c18:	83 fa 02             	cmp    $0x2,%edx
    1c1b:	0f 94 c0             	sete   %al
    1c1e:	50                   	push   %eax
    1c1f:	57                   	push   %edi
    1c20:	e8 84 fb ff ff       	call   17a9 <wait_task_stopped>
    1c25:	89 c7                	mov    %eax,%edi
    1c27:	83 c4 18             	add    $0x18,%esp
    1c2a:	83 f8 f5             	cmp    $0xfffffff5,%eax
    1c2d:	0f 84 31 ff ff ff    	je     1b64 <do_wait+0x3d>
    1c33:	eb 5d                	jmp    1c92 <do_wait+0x16b>
    1c35:	8b 47 78             	mov    0x78(%edi),%eax
    1c38:	83 f8 20             	cmp    $0x20,%eax
    1c3b:	74 64                	je     1ca1 <do_wait+0x17a>
    1c3d:	83 f8 10             	cmp    $0x10,%eax
    1c40:	75 2f                	jne    1c71 <do_wait+0x14a>
    1c42:	83 fa 02             	cmp    $0x2,%edx
    1c45:	74 2a                	je     1c71 <do_wait+0x14a>
    1c47:	f6 45 0c 04          	testb  $0x4,0xc(%ebp)
    1c4b:	74 54                	je     1ca1 <do_wait+0x17a>
    1c4d:	ff 75 18             	pushl  0x18(%ebp)
    1c50:	ff 75 14             	pushl  0x14(%ebp)
    1c53:	56                   	push   %esi
    1c54:	8b 45 0c             	mov    0xc(%ebp),%eax
    1c57:	25 00 00 00 01       	and    $0x1000000,%eax
    1c5c:	50                   	push   %eax
    1c5d:	57                   	push   %edi
    1c5e:	e8 8a f7 ff ff       	call   13ed <wait_task_zombie>
    1c63:	89 c7                	mov    %eax,%edi
    1c65:	83 c4 14             	add    $0x14,%esp
    1c68:	85 c0                	test   %eax,%eax
    1c6a:	74 35                	je     1ca1 <do_wait+0x17a>
    1c6c:	e9 f6 00 00 00       	jmp    1d67 <do_wait+0x240>
    1c71:	f6 45 0c 08          	testb  $0x8,0xc(%ebp)
    1c75:	74 23                	je     1c9a <do_wait+0x173>
    1c77:	ff 75 18             	pushl  0x18(%ebp)
    1c7a:	ff 75 14             	pushl  0x14(%ebp)
    1c7d:	56                   	push   %esi
    1c7e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1c81:	25 00 00 00 01       	and    $0x1000000,%eax
    1c86:	50                   	push   %eax
    1c87:	57                   	push   %edi
    1c88:	e8 a5 fd ff ff       	call   1a32 <wait_task_continued>
    1c8d:	89 c7                	mov    %eax,%edi
    1c8f:	83 c4 14             	add    $0x14,%esp
    1c92:	85 ff                	test   %edi,%edi
    1c94:	0f 85 cd 00 00 00    	jne    1d67 <do_wait+0x240>
    1c9a:	c7 45 d8 01 00 00 00 	movl   $0x1,0xffffffd8(%ebp)
    1ca1:	8b 45 dc             	mov    0xffffffdc(%ebp),%eax
    1ca4:	8b 00                	mov    (%eax),%eax
    1ca6:	89 45 dc             	mov    %eax,0xffffffdc(%ebp)
    1ca9:	8b 55 dc             	mov    0xffffffdc(%ebp),%edx
    1cac:	8b 02                	mov    (%edx),%eax
    1cae:	8d 74 26 00          	lea    0x0(%esi),%esi
    1cb2:	8d 83 a0 00 00 00    	lea    0xa0(%ebx),%eax
    1cb8:	39 c2                	cmp    %eax,%edx
    1cba:	0f 85 c7 fe ff ff    	jne    1b87 <do_wait+0x60>
    1cc0:	83 7d d8 00          	cmpl   $0x0,0xffffffd8(%ebp)
    1cc4:	75 3a                	jne    1d00 <do_wait+0x1d9>
    1cc6:	8b 7b 5c             	mov    0x5c(%ebx),%edi
    1cc9:	eb 21                	jmp    1cec <do_wait+0x1c5>
    1ccb:	8d 47 9c             	lea    0xffffff9c(%edi),%eax
    1cce:	50                   	push   %eax
    1ccf:	ff 75 0c             	pushl  0xc(%ebp)
    1cd2:	ff 75 08             	pushl  0x8(%ebp)
    1cd5:	e8 21 f5 ff ff       	call   11fb <eligible_child>
    1cda:	83 c4 0c             	add    $0xc,%esp
    1cdd:	85 c0                	test   %eax,%eax
    1cdf:	74 09                	je     1cea <do_wait+0x1c3>
    1ce1:	c7 45 d8 01 00 00 00 	movl   $0x1,0xffffffd8(%ebp)
    1ce8:	eb 16                	jmp    1d00 <do_wait+0x1d9>
    1cea:	8b 3f                	mov    (%edi),%edi
    1cec:	8b 07                	mov    (%edi),%eax
    1cee:	8d 74 26 00          	lea    0x0(%esi),%esi
    1cf2:	8d 43 5c             	lea    0x5c(%ebx),%eax
    1cf5:	39 c7                	cmp    %eax,%edi
    1cf7:	75 d2                	jne    1ccb <do_wait+0x1a4>
    1cf9:	c7 45 d8 00 00 00 00 	movl   $0x0,0xffffffd8(%ebp)
    1d00:	f7 45 0c 00 00 00 20 	testl  $0x20000000,0xc(%ebp)
    1d07:	75 33                	jne    1d3c <do_wait+0x215>
    1d09:	8b 9b d4 00 00 00    	mov    0xd4(%ebx),%ebx
    1d0f:	81 eb d4 00 00 00    	sub    $0xd4,%ebx
    1d15:	b8 00 e0 ff ff       	mov    $0xffffe000,%eax
    1d1a:	21 e0                	and    %esp,%eax
    1d1c:	8b 10                	mov    (%eax),%edx
    1d1e:	8b 82 5c 04 00 00    	mov    0x45c(%edx),%eax
    1d24:	39 83 5c 04 00 00    	cmp    %eax,0x45c(%ebx)
    1d2a:	74 08                	je     1d34 <do_wait+0x20d>
    1d2c:	0f 0b                	ud2a   
    1d2e:	88 05 00 00 00 00    	mov    %al,0x0
    1d34:	39 d3                	cmp    %edx,%ebx
    1d36:	0f 85 40 fe ff ff    	jne    1b7c <do_wait+0x55>
    1d3c:	83 7d d8 00          	cmpl   $0x0,0xffffffd8(%ebp)
    1d40:	74 62                	je     1da4 <do_wait+0x27d>
    1d42:	f6 45 0c 01          	testb  $0x1,0xc(%ebp)
    1d46:	75 1d                	jne    1d65 <do_wait+0x23e>
    1d48:	b8 00 e0 ff ff       	mov    $0xffffe000,%eax
    1d4d:	21 e0                	and    %esp,%eax
    1d4f:	8b 00                	mov    (%eax),%eax
    1d51:	8b 40 04             	mov    0x4(%eax),%eax
    1d54:	8b 40 08             	mov    0x8(%eax),%eax
    1d57:	a8 04                	test   $0x4,%al
    1d59:	75 42                	jne    1d9d <do_wait+0x276>
    1d5b:	e8 fc ff ff ff       	call   1d5c <do_wait+0x235>
    1d60:	e9 ff fd ff ff       	jmp    1b64 <do_wait+0x3d>
    1d65:	31 ff                	xor    %edi,%edi
    1d67:	bb 00 e0 ff ff       	mov    $0xffffe000,%ebx
    1d6c:	21 e3                	and    %esp,%ebx
    1d6e:	8b 03                	mov    (%ebx),%eax
    1d70:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    1d76:	8b 03                	mov    (%ebx),%eax
    1d78:	8b 80 5c 04 00 00    	mov    0x45c(%eax),%eax
    1d7e:	83 c0 08             	add    $0x8,%eax
    1d81:	8d 55 e0             	lea    0xffffffe0(%ebp),%edx
    1d84:	e8 fc ff ff ff       	call   1d85 <do_wait+0x25e>
    1d89:	85 f6                	test   %esi,%esi
    1d8b:	0f 84 f0 00 00 00    	je     1e81 <do_wait+0x35a>
    1d91:	83 ff 00             	cmp    $0x0,%edi
    1d94:	7e 15                	jle    1dab <do_wait+0x284>
    1d96:	31 ff                	xor    %edi,%edi
    1d98:	e9 e4 00 00 00       	jmp    1e81 <do_wait+0x35a>
    1d9d:	bf 00 fe ff ff       	mov    $0xfffffe00,%edi
    1da2:	eb c3                	jmp    1d67 <do_wait+0x240>
    1da4:	bf f6 ff ff ff       	mov    $0xfffffff6,%edi
    1da9:	eb bc                	jmp    1d67 <do_wait+0x240>
    1dab:	0f 85 d0 00 00 00    	jne    1e81 <do_wait+0x35a>
    1db1:	8b 4b 18             	mov    0x18(%ebx),%ecx
    1db4:	89 f2                	mov    %esi,%edx
    1db6:	83 c2 04             	add    $0x4,%edx
    1db9:	19 c0                	sbb    %eax,%eax
    1dbb:	39 d1                	cmp    %edx,%ecx
    1dbd:	83 d8 00             	sbb    $0x0,%eax
    1dc0:	85 c0                	test   %eax,%eax
    1dc2:	0f 85 b4 00 00 00    	jne    1e7c <do_wait+0x355>
    1dc8:	89 f8                	mov    %edi,%eax
    1dca:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
    1dd0:	85 c0                	test   %eax,%eax
    1dd2:	0f 85 84 00 00 00    	jne    1e5c <do_wait+0x335>
    1dd8:	8d 46 04             	lea    0x4(%esi),%eax
    1ddb:	89 c2                	mov    %eax,%edx
    1ddd:	83 c2 04             	add    $0x4,%edx
    1de0:	19 db                	sbb    %ebx,%ebx
    1de2:	39 d1                	cmp    %edx,%ecx
    1de4:	83 db 00             	sbb    $0x0,%ebx
    1de7:	85 db                	test   %ebx,%ebx
    1de9:	0f 85 8d 00 00 00    	jne    1e7c <do_wait+0x355>
    1def:	89 f8                	mov    %edi,%eax
    1df1:	c7 46 04 00 00 00 00 	movl   $0x0,0x4(%esi)
    1df8:	85 c0                	test   %eax,%eax
    1dfa:	75 60                	jne    1e5c <do_wait+0x335>
    1dfc:	8d 46 08             	lea    0x8(%esi),%eax
    1dff:	89 c2                	mov    %eax,%edx
    1e01:	83 c2 04             	add    $0x4,%edx
    1e04:	19 db                	sbb    %ebx,%ebx
    1e06:	39 d1                	cmp    %edx,%ecx
    1e08:	83 db 00             	sbb    $0x0,%ebx
    1e0b:	85 db                	test   %ebx,%ebx
    1e0d:	75 6d                	jne    1e7c <do_wait+0x355>
    1e0f:	89 f8                	mov    %edi,%eax
    1e11:	c7 46 08 00 00 00 00 	movl   $0x0,0x8(%esi)
    1e18:	85 c0                	test   %eax,%eax
    1e1a:	75 40                	jne    1e5c <do_wait+0x335>
    1e1c:	8d 46 0c             	lea    0xc(%esi),%eax
    1e1f:	89 c2                	mov    %eax,%edx
    1e21:	83 c2 04             	add    $0x4,%edx
    1e24:	19 db                	sbb    %ebx,%ebx
    1e26:	39 d1                	cmp    %edx,%ecx
    1e28:	83 db 00             	sbb    $0x0,%ebx
    1e2b:	85 db                	test   %ebx,%ebx
    1e2d:	75 4d                	jne    1e7c <do_wait+0x355>
    1e2f:	89 f8                	mov    %edi,%eax
    1e31:	c7 46 0c 00 00 00 00 	movl   $0x0,0xc(%esi)
    1e38:	85 c0                	test   %eax,%eax
    1e3a:	75 20                	jne    1e5c <do_wait+0x335>
    1e3c:	8d 46 10             	lea    0x10(%esi),%eax
    1e3f:	89 c2                	mov    %eax,%edx
    1e41:	83 c2 04             	add    $0x4,%edx
    1e44:	19 db                	sbb    %ebx,%ebx
    1e46:	39 d1                	cmp    %edx,%ecx
    1e48:	83 db 00             	sbb    $0x0,%ebx
    1e4b:	85 db                	test   %ebx,%ebx
    1e4d:	75 2d                	jne    1e7c <do_wait+0x355>
    1e4f:	89 f8                	mov    %edi,%eax
    1e51:	c7 46 10 00 00 00 00 	movl   $0x0,0x10(%esi)
    1e58:	85 c0                	test   %eax,%eax
    1e5a:	74 04                	je     1e60 <do_wait+0x339>
    1e5c:	89 c7                	mov    %eax,%edi
    1e5e:	eb 21                	jmp    1e81 <do_wait+0x35a>
    1e60:	8d 46 14             	lea    0x14(%esi),%eax
    1e63:	89 c2                	mov    %eax,%edx
    1e65:	83 c2 04             	add    $0x4,%edx
    1e68:	19 db                	sbb    %ebx,%ebx
    1e6a:	39 d1                	cmp    %edx,%ecx
    1e6c:	83 db 00             	sbb    $0x0,%ebx
    1e6f:	85 db                	test   %ebx,%ebx
    1e71:	75 09                	jne    1e7c <do_wait+0x355>
    1e73:	c7 46 14 00 00 00 00 	movl   $0x0,0x14(%esi)
    1e7a:	eb 05                	jmp    1e81 <do_wait+0x35a>
    1e7c:	bf f2 ff ff ff       	mov    $0xfffffff2,%edi
    1e81:	89 f8                	mov    %edi,%eax
    1e83:	8d 65 f4             	lea    0xfffffff4(%ebp),%esp
    1e86:	5b                   	pop    %ebx
    1e87:	5e                   	pop    %esi
    1e88:	5f                   	pop    %edi
    1e89:	5d                   	pop    %ebp
    1e8a:	c3                   	ret    


-- 
The only thing necessary for the triumph of evil
  is for good men to do nothing.
                                           - Edmund Burke
